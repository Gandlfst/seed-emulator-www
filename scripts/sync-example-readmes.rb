#!/usr/bin/env ruby
# Copy upstream READMEs and prepend one fixed Jekyll layout header.
# Usage: ruby scripts/sync-example-readmes.rb
require 'yaml'
require 'open-uri'
require 'fileutils'

# Use this Windows machine's local proxy unless a proxy is already configured.
# Other platforms keep their existing network settings.
if RUBY_PLATFORM.match?(/mswin|mingw|cygwin/) && !ENV.key?('https_proxy') && !ENV.key?('HTTPS_PROXY')
  ENV['https_proxy'] = 'http://127.0.0.1:7890'
end

# Download only the README for each example listed on this website.
root = File.expand_path('..', __dir__)
remote = 'https://raw.githubusercontent.com/seed-labs/seed-emulator/master'

# Each project examples.yml records its upstream directories and local page slugs.
output = File.join(root, 'pages', 'examples', '_example_readmes')
FileUtils.mkdir_p(output)
lessons = %w[internet satellite blockchain].flat_map do |project|
  YAML.safe_load_file(File.join(root, '_data', project, 'examples.yml'))
end
lessons.each do |lesson|
  filename = lesson.fetch('slug') + '.md'
  readme = URI.open("#{remote}/#{lesson.fetch('source_path')}/README.md", open_timeout: 15, read_timeout: 30, &:read)
  File.binwrite(File.join(output, filename), "---\nlayout: example-readme\n---\n\n" + readme)
  puts "Copied #{filename}"
end
