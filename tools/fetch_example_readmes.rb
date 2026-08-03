#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"
require "net/http"
require "uri"
require "yaml"

ROOT = File.expand_path("..", __dir__)
SOURCES_FILE = File.join(ROOT, "_data", "example_sources.yml")
LOCAL_EXAMPLES_ROOT = ENV["SEED_EMULATOR_EXAMPLES_ROOT"]

def fetch_text(url)
  uri = URI(url)
  response = Net::HTTP.start(
    uri.host,
    uri.port,
    use_ssl: uri.scheme == "https",
    open_timeout: 10,
    read_timeout: 30
  ) do |http|
    request = Net::HTTP::Get.new(uri)
    request["User-Agent"] = "seed-emulator-www-readme-fetcher"
    http.request(request)
  end
  raise "Failed to fetch #{url}: #{response.code}" unless response.is_a?(Net::HTTPSuccess)

  response.body
end

def read_readme(source)
  if LOCAL_EXAMPLES_ROOT && !LOCAL_EXAMPLES_ROOT.empty?
    local_readme = File.join(LOCAL_EXAMPLES_ROOT, source.fetch("source_path"), "README.md")
    return File.read(local_readme, encoding: "UTF-8") if File.file?(local_readme)
  end

  repo = source.fetch("repository_url").sub(%r{/$}, "")
  branch = source.fetch("branch", "master")
  path = source.fetch("source_path")
  raw_url = "#{repo.sub("github.com", "raw.githubusercontent.com")}/#{branch}/#{path}/README.md"
  fetch_text(raw_url)
end

sources = YAML.load_file(SOURCES_FILE)

sources.each do |source|
  markdown = read_readme(source).encode("UTF-8", invalid: :replace, undef: :replace)
  output = File.join(ROOT, "_includes", source.fetch("readme_include"))
  FileUtils.mkdir_p(File.dirname(output))
  File.write(output, markdown, encoding: "UTF-8")
  puts "Fetched #{source.fetch("source_path")}/README.md"
end
