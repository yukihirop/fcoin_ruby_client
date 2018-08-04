lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "fcoin/version"

Gem::Specification.new do |spec|
  spec.name          = "fcoin_ruby_client"
  spec.version       = Fcoin::VERSION
  spec.authors       = ["yukihirop"]
  spec.email         = ["yfsidejob@gmail.com"]

  spec.summary       = %q{A Ruby wrapper for Fcoin API}
  spec.description   = %q{A Ruby wrapper for Fcoin API}
  spec.license       = "MIT".freeze

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.1p111".freeze)

  spec.add_development_dependency "bundler", "~> 1.16.a"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "webmock", '~> 3.4.2'
  spec.add_development_dependency "vcr", '~>4.0.0'
  spec.add_development_dependency "yard", '~>0.9.15'
  spec.add_development_dependency "rubocop", '~>0.53.0'
  spec.add_development_dependency "onkcop", '~>0.53.0.0'
  spec.add_development_dependency "simplecov", '~>0.16.1'
  spec.add_development_dependency "coveralls", '0.7.1'

  spec.add_runtime_dependency "faraday", '~>0.15.2'
  spec.add_runtime_dependency "faraday_middleware", '~>0.12.2'
  spec.add_runtime_dependency "activesupport", '~>5.2.0'
  spec.add_runtime_dependency "faye-websocket", '~>0.10.7'
  spec.add_runtime_dependency "config",'~>1.7.0'
  spec.add_runtime_dependency "thor", '~>0.20.0'
end
