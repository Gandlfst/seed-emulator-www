# Keep the PDF source in assets/papers while publishing its short URL.
Jekyll::Hooks.register :site, :post_write do |site|
  source = site.in_source_dir("assets/papers/sigcse_2027.pdf")
  target = site.in_dest_dir("papers/sigcse_2027.pdf")
  FileUtils.mkdir_p(File.dirname(target))
  FileUtils.cp(source, target)
end
