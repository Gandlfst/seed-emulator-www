#!/usr/bin/env ruby
# Download Markdown, add Jekyll front matter, and fix the manuals' inline links.
require 'yaml'
require 'open-uri'
require 'fileutils'
require 'pathname'
require 'optparse'

if RUBY_PLATFORM.match?(/mswin|mingw|cygwin/) && !ENV.key?('https_proxy') && !ENV.key?('HTTPS_PROXY')
  ENV['https_proxy'] = 'http://127.0.0.1:7890'
end

module UpstreamDocs
  MANUAL_ROOT = 'docs/user-manual/'
  MANUAL_INDEX = "#{MANUAL_ROOT}user-manual.md"
  SITE_ROOT = '/internet-emulator/how-to-use/visualization/'
  REPOSITORY = 'https://github.com/seed-labs/seed-visualization'
  RAW_ROOT = 'https://raw.githubusercontent.com/seed-labs/seed-visualization/main/'

  def self.download(url)
    URI.open(url, open_timeout: 15, read_timeout: 30, &:read).force_encoding('UTF-8')
  end

  def self.manual_url(path)
    return SITE_ROOT if path == MANUAL_INDEX

    "#{SITE_ROOT}#{path.delete_prefix(MANUAL_ROOT).sub(/\.md\z/, '').sub(/\/README\z/, '')}/"
  end

  def self.rewrite(markdown, source, pending)
    # Skip code; replace ordinary [links](path) and ![images](path) only.
    markdown.gsub(/(`+).*?\1|~~~.*?~~~|(!?\[[^\]\n]*\]\()([^\s)]+)(\))/m) do |match|
      _, opening, link, closing = Regexp.last_match.captures
      next match if link.nil? || link.match?(/\A(?:[a-z][a-z0-9+.-]*:|\/\/|#)/i)

      target, suffix = link.split(/(?=[?#])/, 2)
      target = Pathname.new(File.dirname(source)).join(target).cleanpath.to_s.tr('\\', '/').delete_prefix('/')
      raise "Link escapes repository: #{link}" if target == '..' || target.start_with?('../')

      url = if opening.start_with?('!')
              RAW_ROOT + target
            elsif target.start_with?(MANUAL_ROOT) && target.end_with?('.md')
              pending << target
              manual_url(target)
            else
              "#{REPOSITORY}/#{File.extname(target).empty? ? 'tree' : 'blob'}/main/#{target}"
            end
      "#{opening}#{url}#{suffix}#{closing}"
    end
  end

  def self.sync_examples(root, fetch: method(:download))
    output = File.join(root, 'pages/examples/_example_readmes')
    FileUtils.mkdir_p(output)
    lessons = %w[internet satellite blockchain].flat_map do |project|
      YAML.safe_load_file(File.join(root, '_data', project, 'examples.yml'))
    end
    lessons.each do |lesson|
      readme = fetch.call("https://raw.githubusercontent.com/seed-labs/seed-emulator/master/#{lesson.fetch('source_path')}/README.md")
      File.binwrite(File.join(output, "#{lesson.fetch('slug')}.md"), "---\nlayout: example-readme\n---\n\n" + readme)
      puts "Copied #{lesson.fetch('slug')}.md"
    end
  end

  def self.sync_visualization(root, fetch: method(:download))
    pending, pages = [MANUAL_INDEX], {}
    until pending.empty?
      path = pending.shift
      next if pages.key?(path)

      markdown = fetch.call(RAW_ROOT + path)
      body = rewrite(markdown, path, pending)
      metadata = {
        'layout' => 'manual', 'title' => markdown[/^#\s+(.+?)\s*#*\s*$/, 1] || File.basename(path, '.md'),
        'nav_key' => 'visualization', 'permalink' => manual_url(path),
        'source_path' => path, 'source_url' => "#{REPOSITORY}/blob/main/#{path}"
      }
      pages[path] = [File.join(root, 'pages', manual_url(path).delete_prefix('/'), 'index.md'), metadata.to_yaml + "---\n\n" + body]
    end
    # Download everything successfully before overwriting generated pages.
    pages.each_value do |filename, content|
      FileUtils.mkdir_p(File.dirname(filename))
      File.write(filename, content, encoding: 'UTF-8')
    end
    puts "Imported #{pages.size} visualization manuals; images remain on GitHub."
    pages.size
  end
end

if $PROGRAM_NAME == __FILE__
  mode = :examples
  OptionParser.new do |parser|
    parser.banner = 'Usage: ruby scripts/sync-example-readmes.rb [--visualization | --all]'
    parser.on('--visualization', 'Import visualization manuals only') { mode = :visualization }
    parser.on('--all', 'Import examples and visualization manuals') { mode = :all }
    parser.on('-h', '--help', 'Show usage') { puts parser; exit }
  end.parse!
  abort "Unexpected arguments: #{ARGV.join(' ')}" unless ARGV.empty?
  root = File.expand_path('..', __dir__)
  UpstreamDocs.sync_examples(root) if %i[examples all].include?(mode)
  UpstreamDocs.sync_visualization(root) if %i[visualization all].include?(mode)
end
