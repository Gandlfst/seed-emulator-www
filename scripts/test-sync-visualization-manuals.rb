#!/usr/bin/env ruby
# Offline checks for the inline Markdown format used by the imported manuals.
require 'tmpdir'
require 'stringio'
require_relative 'sync-visualization-manuals'

checks = 0
check = lambda do |expected, actual|
  raise "Expected #{expected.inspect}, got #{actual.inspect}" unless expected == actual
  checks += 1
end
root, raw = VisualizationDocs::SITE_ROOT, VisualizationDocs::RAW_ROOT
check.call('/visualization/', root)
source = 'docs/user-manual/topology/network-map.md'
check.call(root, VisualizationDocs.manual_url(VisualizationDocs::MANUAL_INDEX))
check.call("#{root}topology/", VisualizationDocs.manual_url('docs/user-manual/topology/README.md'))
check.call("[Guide](#{root}geographic-3d/?view=3d#first-walkthrough)", VisualizationDocs.rewrite('[Guide](../geographic-3d/README.md?view=3d#first-walkthrough)', source))
check.call("![Map](#{raw}InternetMap-Toplogy/docs/assets/map.png)", VisualizationDocs.rewrite('![Map](../../../InternetMap-Toplogy/docs/assets/map.png)', source))
check.call('[New](https://github.com/seed-labs/seed-visualization/blob/main/docs/user-manual/topology/new.md)', VisualizationDocs.rewrite('[New](new.md)', source))
check.call('![Map](https://example.org/map.png)', VisualizationDocs.rewrite('![Map](https://example.org/map.png)', source))
unchanged = "[External](https://example.org/a.md) [Anchor](#section)\n```markdown\n[Code](example.md)\n```\n`[Inline](example.md)`\n``[Nested `tick`](example.md)``\n~~~\n[Code](example.md)\n~~~\n"
check.call(unchanged, VisualizationDocs.rewrite(unchanged, source))

Dir.mktmpdir('seed-doc-import-test-') do |directory|
  fixture = {
    "#{raw}docs/user-manual/user-manual.md" => "# Internet Map\n[New](new.md)\n![Map](../../InternetMap-Toplogy/docs/assets/map.png)\n",
    "#{raw}docs/user-manual/topology/README.md" => "# Topology\n[Manual](../user-manual.md)\n{{ site.title }}\n"
  }
  fetched = []
  manuals = fixture.keys.map { |url| url.delete_prefix(raw) }
  fetch = ->(url) { fetched << url; fixture.fetch(url) }
  previous_stdout, $stdout = $stdout, StringIO.new
  begin
    # 下载清单中的未链接章节，但不追踪文档里新出现的链接。
    VisualizationDocs.sync_visualization(directory, manuals: manuals, fetch: fetch)
    check.call(fixture.keys.sort, fetched.sort)
    check.call(false, Dir.exist?(File.join(directory, 'pages/internet-emulator')))
    files = Dir.glob(File.join(directory, '**/*.md'))
    check.call(2, files.size)
    before = files.to_h { |file| [file, File.binread(file)] }
    index = File.read(File.join(directory, 'pages', root.delete_prefix('/'), 'index.md'))
    metadata = YAML.safe_load(index.split(/^---\s*$\n?/, 3)[1])
    check.call(['manual', 'visualization', root], metadata.values_at('layout', 'nav_key', 'permalink'))
    check.call(true, index.include?("![Map](#{raw}InternetMap-Toplogy/docs/assets/map.png)"))
    check.call(true, before.values.any? { |body| body.include?('{{ site.title }}') })
    VisualizationDocs.sync_visualization(directory, manuals: manuals, fetch: fetch)
    check.call(before, files.to_h { |file| [file, File.binread(file)] })
    begin
      VisualizationDocs.sync_visualization(directory, manuals: manuals, fetch: ->(url) { raise IOError unless url == fixture.keys.first; "# New\n[Missing](missing.md)" })
      raise 'Expected download failure'
    rescue IOError
      check.call(true, File.read(File.join(directory, 'pages/visualization/index.md')).include?("# New\n"))
      chapter = files.find { |file| file.end_with?('/topology/index.md') }
      check.call(before.fetch(chapter), File.binread(chapter))
    end
  ensure
    $stdout = previous_stdout
  end
end
puts "PASS: #{checks} checks (fixed list, inline links, images, code preservation, repeat imports, and per-page writes)."
