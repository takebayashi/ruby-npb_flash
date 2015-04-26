# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'npb_flash/version'

Gem::Specification.new do |spec|
  spec.name          = "npb_flash"
  spec.version       = NpbFlash::VERSION
  spec.authors       = ["Shun Takebayashi"]
  spec.email         = ["shun@takebayashi.asia"]

  spec.summary       = %q{Scraping library for NPB score flash news of Yahoo! JAPAN SportsNavi}
  spec.homepage      = "https://github.com/takebayashi/ruby-npb_flash"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_dependency "nokogiri"
end
