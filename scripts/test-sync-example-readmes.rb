#!/usr/bin/env ruby
# Offline checks for the inline Markdown format used by the imported manuals.
require 'tmpdir'
require 'stringio'
require_relative 'sync-example-readmes'

checks = 0
check = lambda do |expected, actual|
  raise "Expected #{expected.inspect}, got #{actual.inspect}" unless expected == actual
  checks += 1
end
root, raw = UpstreamDocs::SITE_ROOT, UpstreamDocs::RAW_ROOT
check.call('/visualization/', root)
pending = []
source = 'docs/user-manual/topology/network-map.md'
check.call(root, UpstreamDocs.manual_url(UpstreamDocs::MANUAL_INDEX))
check.call("#{root}topology/", UpstreamDocs.manual_url('docs/user-manual/topology/README.md'))
check.call("[Guide](#{root}geographic-3d/?view=3d#first-walkthrough)", UpstreamDocs.rewrite('[Guide](../geographic-3d/README.md?view=3d#first-walkthrough)', source, pending))
check.call("![Map](#{raw}InternetMap-Toplogy/docs/assets/map.png)", UpstreamDocs.rewrite('![Map](../../../InternetMap-Toplogy/docs/assets/map.png)', source, pending))
check.call(['docs/user-manual/geographic-3d/README.md'], pending)
unchanged = "[External](https://example.org/a.md) [Anchor](#section)\n```markdown\n[Code](example.md)\n```\n`[Inline](example.md)`\n``[Nested `tick`](example.md)``\n~~~\n[Code](example.md)\n~~~\n"
check.call(unchanged, UpstreamDocs.rewrite(unchanged, source, []))

Dir.mktmpdir('seed-doc-import-test-') do |directory|
  fixture = {
    "#{raw}docs/user-manual/user-manual.md" => "# Internet Map\n[Topology](topology/README.md)\n![Map](../../InternetMap-Toplogy/docs/assets/map.png)\n",
    "#{raw}docs/user-manual/topology/README.md" => "# Topology\n[Manual](../user-manual.md)\n{{ site.title }}\n"
  }
  fetched = []
  fetch = ->(url) { fetched << url; fixture.fetch(url) }
  previous_stdout, $stdout = $stdout, StringIO.new
  begin
    check.call(2, UpstreamDocs.sync_visualization(directory, fetch: fetch))
    check.call(fixture.keys.sort, fetched.sort)
    check.call(false, Dir.exist?(File.join(directory, 'pages/internet-emulator')))
    files = Dir.glob(File.join(directory, '**/*.md'))
    before = files.to_h { |file| [file, File.binread(file)] }
    index = File.read(File.join(directory, 'pages', root.delete_prefix('/'), 'index.md'))
    metadata = YAML.safe_load(index.split(/^---\s*$\n?/, 3)[1])
    check.call(['manual', 'visualization', root], metadata.values_at('layout', 'nav_key', 'permalink'))
    check.call(true, index.include?("![Map](#{raw}InternetMap-Toplogy/docs/assets/map.png)"))
    check.call(true, before.values.any? { |body| body.include?('{{ site.title }}') })
    check.call(2, UpstreamDocs.sync_visualization(directory, fetch: fetch))
    check.call(before, files.to_h { |file| [file, File.binread(file)] })
    begin
      UpstreamDocs.sync_visualization(directory, fetch: ->(url) { raise IOError unless url == fixture.keys.first; "# New\n[Missing](missing.md)" })
      raise 'Expected download failure'
    rescue IOError
      check.call(before, files.to_h { |file| [file, File.binread(file)] })
    end
    %w[internet satellite blockchain].each do |project|
      FileUtils.mkdir_p(File.join(directory, '_data', project))
      records = project == 'internet' ? [{ 'slug' => 'a00', 'source_path' => 'examples/A00' }] : []
      File.write(File.join(directory, '_data', project, 'examples.yml'), records.to_yaml)
    end
    UpstreamDocs.sync_examples(directory, fetch: ->(_url) { "# Example\n[Unchanged](relative.md)\n" })
    check.call("---\nlayout: example-readme\n---\n\n# Example\n[Unchanged](relative.md)\n", File.binread(File.join(directory, 'pages/examples/_example_readmes/a00.md')))
  ensure
    $stdout = previous_stdout
  end
end
puts "PASS: #{checks} checks (inline links, images, code preservation, duplicate links, failure safety, and examples)."
