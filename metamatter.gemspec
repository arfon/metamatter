# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'metamatter/version'

Gem::Specification.new do |spec|
  spec.name          = "metamatter"
  spec.version       = Metamatter::VERSION
  spec.authors       = ["Arfon Smith"]
  spec.email         = ["arfon.smith@gmail.com"]
  spec.summary       = "A Ruby Gem for extracting minmal metadata from a GitHub repository"
  spec.homepage      = "https://github.com/arfon/metamatter"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "algorithmia", "~> 0.2.0"
  spec.add_dependency "octokit", "~> 4.0"
  spec.add_dependency "thor", "~> 0.19"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "rspec", "~> 3.3"
end
