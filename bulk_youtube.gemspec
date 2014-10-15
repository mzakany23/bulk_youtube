# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bulk_youtube/version'

Gem::Specification.new do |spec|
  spec.name          = "bulk_youtube"
  spec.version       = BulkYoutube::VERSION
  spec.authors       = ["Michael C. Zakany"]
  spec.email         = ["mzakany@gmail.com"]
  spec.description   = %q{Download batches of youtube videos}
  spec.summary       = %q{Download Batches of youtube videos}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri"
  spec.add_dependency "mechanize"
  
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
