Gem::Specification.new do |s|
  s.name = "sequel_fresh_connections"
  s.version = "0.2.0"
  s.summary = "Keep your Sequel DB connections fresh"
  s.description = "A Sequel extension to remove stale, potentially timed out, connections from the connection pool."
  s.files = %W{lib}.map {|dir| Dir["#{dir}/**/*.rb"]}.flatten << "README.rdoc"
  s.require_path = "lib"
  s.rdoc_options = ["--main", "README.rdoc", "--charset", "utf-8"]
  s.extra_rdoc_files = ["README.rdoc"]
  s.author = "Matthew Sadler"
  s.email = "mat@sourcetagsandcodes.com"
  s.homepage = "https://github.com/globaldev/sequel_fresh_connections"
  s.add_dependency("sequel", ">= 3.41.0")
end
