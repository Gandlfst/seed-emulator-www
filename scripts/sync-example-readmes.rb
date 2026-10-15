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

# Each lesson already records the path of its upstream example directory.
output = File.join(root, '_example_readmes')
FileUtils.mkdir_p(output)
Dir.glob(File.join(root, '_examples', '*.md')).sort.each do |file|
  lesson = YAML.safe_load(File.read(file, encoding: 'UTF-8').split(/^---\s*$/, 3)[1])
  readme = URI.open("#{remote}/#{lesson.fetch('source_path')}/README.md", open_timeout: 15, read_timeout: 30, &:read)
  File.binwrite(File.join(output, File.basename(file)), "---\nlayout: default\n---\n\n" + readme)
  puts "Copied #{File.basename(file)}"
end
