# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "quokka/version"

Gem::Specification.new do |spec|
  spec.name          = "quokka"
  spec.version       = Quokka::VERSION
  spec.authors       = ["Tom Kruijsen"]
  spec.email         = ["tom@tomkruijsen.nl"]

  spec.summary       = "Tools for logging in with Facebook."
  spec.description   = <<-EOF
    Quokka provides tools to make logging in with Facebook from your server a
    breeze.
  EOF
  spec.homepage      = "http://github.com/tomkr/quokka"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop-rspec", "~> 1.5"
  spec.add_development_dependency "rubocop", "~> 0.40"
  spec.add_development_dependency "simplecov", "~> 0.11"
end
