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

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16.a"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "onkcop"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "coveralls"

  spec.add_runtime_dependency "faraday"
  spec.add_runtime_dependency "faraday_middleware"
  spec.add_runtime_dependency "activesupport"
  spec.add_runtime_dependency "faye-websocket"
  spec.add_runtime_dependency "config"
  spec.add_runtime_dependency "thor"
end
