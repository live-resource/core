# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'live_resource/version'

Gem::Specification.new do |spec|
  spec.name          = "live_resource"
  spec.version       = LiveResource::VERSION
  spec.authors       = ["Will Madden"]
  spec.email         = ["will@letsgeddit.com"]
  spec.description   = %q{A DSL for describing resources that change in real time}
  spec.summary       = %q{A DSL for describing resources that change in real time}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
