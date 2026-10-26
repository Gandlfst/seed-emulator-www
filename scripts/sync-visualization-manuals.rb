#!/usr/bin/env ruby
# 从 GitHub 导入 Visualization 手册，并修正文档中的链接。
# 运行：ruby scripts/sync-visualization-manuals.rb
# 流程：读取固定清单 → 下载 → 修正链接 → 写入 pages/visualization/。
require 'yaml'
require 'open-uri'
require 'fileutils'
require 'pathname'

# Windows 未设置 HTTPS 代理时，使用本机 7890 端口；其他系统不修改代理。
if RUBY_PLATFORM.match?(/mswin|mingw|cygwin/) && !ENV.key?('https_proxy') && !ENV.key?('HTTPS_PROXY')
  ENV['https_proxy'] = 'http://127.0.0.1:7890'
end

module VisualizationDocs
  # 上游手册目录、入口文档、本网站地址，以及 GitHub 仓库和原始文件地址。
  MANUAL_ROOT = 'docs/user-manual/'
  MANUAL_INDEX = "#{MANUAL_ROOT}user-manual.md"
  SITE_ROOT = '/visualization/'
  REPOSITORY = 'https://github.com/seed-labs/seed-visualization'
  RAW_ROOT = 'https://raw.githubusercontent.com/seed-labs/seed-visualization/main/'

  # 只导入这份清单中的手册；新增章节时在这里添加路径。
  MANUALS = %w[
    user-manual.md
    geographic-2d/README.md
    geographic-3d/README.md
    geographic-3d/live-topology.md
    geographic-3d/node-actions.md
    geographic-3d/overview-filters.md
    geographic-3d/search-display.md
    geographic-3d/traffic-replay.md
    geographic-3d/upload-topology.md
    topology/README.md
    topology/dashboard.md
    topology/ix-view.md
    topology/network-map.md
    topology/node-actions.md
    topology/plugins.md
    topology/search-display.md
    topology/traffic-replay.md
    topology/transit-view.md
    topology/upload-topology.md
  ].map { |path| MANUAL_ROOT + path }.freeze

  def self.download(url)
    # 下载文本；连接最多等待 15 秒，读取超时为 30 秒，按 UTF-8 处理。
    URI.open(url, open_timeout: 15, read_timeout: 30, &:read).force_encoding('UTF-8')
  end

  def self.manual_url(path)
    # 把上游文件路径映射为网站地址：入口对应 /visualization/，
    # 例如 docs/user-manual/topology/README.md 对应 /visualization/topology/。
    return SITE_ROOT if path == MANUAL_INDEX

    "#{SITE_ROOT}#{path.delete_prefix(MANUAL_ROOT).sub(/\.md\z/, '').sub(/\/README\z/, '')}/"
  end

  def self.rewrite(markdown, source, manuals = MANUALS)
    # source 是当前文档的上游路径；这里只改链接，不再查找或下载新章节。
    # 匹配常见代码片段以保留原文，只改写普通 [文字](路径) 和 ![图片](路径)。
    # 不处理 HTML 链接和引用式 Markdown 链接。
    markdown.gsub(/(`+).*?\1|~~~.*?~~~|(!?\[[^\]\n]*\]\()([^\s)]+)(\))/m) do |match|
      _, opening, link, closing = Regexp.last_match.captures
      # 代码片段、完整外链和页内 #锚点不改动。
      next match if link.nil? || link.match?(/\A(?:[a-z][a-z0-9+.-]*:|\/\/|#)/i)

      target, suffix = link.split(/(?=[?#])/, 2)
      # 保留 ?参数 和 #锚点；相对路径按当前文档所在目录解析。
      target = Pathname.new(File.dirname(source)).join(target).cleanpath.to_s.tr('\\', '/').delete_prefix('/')
      raise "Link escapes repository: #{link}" if target == '..' || target.start_with?('../')

      url = if opening.start_with?('!')
              # 图片直接使用 GitHub 原始文件地址，不下载到本地。
              RAW_ROOT + target
            elsif manuals.include?(target)
              # 清单内的章节使用站内地址；未导入的章节继续链接到 GitHub。
              manual_url(target)
            else
              # 其他资源链接回 GitHub；按有无扩展名选择文件或目录页面。
              "#{REPOSITORY}/#{File.extname(target).empty? ? 'tree' : 'blob'}/main/#{target}"
            end
      "#{opening}#{url}#{suffix}#{closing}"
    end
  end

  def self.sync_visualization(root, manuals: MANUALS, fetch: method(:download))
    # root 是本地网站根目录。fetch 默认执行下载，离线测试可替换为模拟数据。
    # 按固定清单逐篇下载，下载一篇就保存一篇。
    manuals.each do |path|
      markdown = fetch.call(RAW_ROOT + path)
      body = rewrite(markdown, path, manuals)
      # 给 Markdown 添加 Jekyll 页面配置：布局、标题、导航、网址和来源。
      metadata = {
        'layout' => 'manual', 'title' => markdown[/^#\s+(.+?)\s*#*\s*$/, 1] || File.basename(path, '.md'),
        'nav_key' => 'visualization', 'permalink' => manual_url(path),
        'source_path' => path, 'source_url' => "#{REPOSITORY}/blob/main/#{path}"
      }
      filename = File.join(root, 'pages', manual_url(path).delete_prefix('/'), 'index.md')
      FileUtils.mkdir_p(File.dirname(filename))
      File.write(filename, metadata.to_yaml + "---\n\n" + body, encoding: 'UTF-8')
    end
  end
end

# 只有直接运行此脚本才开始导入；被测试脚本 require 时不会访问网络。
if $PROGRAM_NAME == __FILE__
  abort 'Usage: ruby scripts/sync-visualization-manuals.rb' unless ARGV.empty?
  root = File.expand_path('..', __dir__)
  VisualizationDocs.sync_visualization(root)
end
