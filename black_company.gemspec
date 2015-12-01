# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'black_company/version'

Gem::Specification.new do |spec|
  spec.name          = "black_company"
  spec.version       = BlackCompany::VERSION
  spec.authors       = ["nownabe"]
  spec.email         = ["nownabe@gmail.com"]

  spec.summary       = %q{BlackCompany provides workhorses. But there is a limit to the number of them. So it's a thread pool :yum:}
  spec.homepage      = "https://github.com/nownabe/black_company"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "codeclimate-test-reporter"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov"
end
