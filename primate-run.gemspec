# frozen_string_literal: true

require_relative "lib/primate/version"

Gem::Specification.new do |spec|
  spec.name = "primate-run"
  spec.version = Primate::VERSION
  spec.summary = "Ruby route handlers for the Primate web framework"
  spec.description = "Provides Ruby support for building web applications with the Primate framework"
  spec.authors = ["Primate Team"]
  spec.email = ["terrablue@proton.me"]
  spec.homepage = "https://primate.run"
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/primate-run/ruby"
  spec.metadata["bug_tracker_uri"] = "https://github.com/primate-run/ruby/issues"

  spec.files = Dir["lib/**/*.rb", "sig/**/*.rbs"]

  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 3.0.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "ruby-lsp", "~> 0.26"
end
