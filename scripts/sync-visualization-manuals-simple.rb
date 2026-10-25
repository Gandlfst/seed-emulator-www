#!/usr/bin/env ruby
# 简化版：仅用于上游图片和章节链接都已改成可直接访问地址的情况。
# 原样复制 Markdown 正文，不转换链接；下载一篇就保存一篇。
# 运行：ruby scripts/sync-visualization-manuals-simple.rb
require 'yaml'
require 'open-uri'
require 'fileutils'

if RUBY_PLATFORM.match?(/mswin|mingw|cygwin/) && !ENV.key?('https_proxy') && !ENV.key?('HTTPS_PROXY')
  ENV['https_proxy'] = 'http://127.0.0.1:7890'
end

root = File.expand_path('..', __dir__)
repository = 'https://github.com/seed-labs/seed-visualization'
remote = 'https://raw.githubusercontent.com/seed-labs/seed-visualization/main'

# 固定手册清单，相对于上游 docs/user-manual/；新增章节时在这里添加。
manuals = %w[
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
]

manuals.each do |manual|
  source = "docs/user-manual/#{manual}"
  markdown = URI.open("#{remote}/#{source}", open_timeout: 15, read_timeout: 30, &:read).force_encoding('UTF-8')

  # 入口保存到 /visualization/；其余文档按章节名生成页面地址。
  slug = manual.sub(/\.md\z/, '').sub(/\/README\z/, '')
  url = manual == 'user-manual.md' ? '/visualization/' : "/visualization/#{slug}/"
  metadata = {
    'layout' => 'manual', 'title' => markdown[/^#\s+(.+?)\s*#*\s*$/, 1] || File.basename(manual, '.md'),
    'nav_key' => 'visualization', 'permalink' => url,
    'source_path' => source, 'source_url' => "#{repository}/blob/main/#{source}"
  }

  # 只添加 Jekyll 页面配置，正文（包括图片和章节链接）保持原样。
  output = File.join(root, 'pages', url.delete_prefix('/'), 'index.md')
  FileUtils.mkdir_p(File.dirname(output))
  File.write(output, metadata.to_yaml + "---\n\n" + markdown, encoding: 'UTF-8')
end
