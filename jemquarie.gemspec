# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jemquarie/version'

Gem::Specification.new do |spec|
  spec.name          = "jemquarie"
  spec.version       = Jemquarie::VERSION
  spec.authors       = ["Claudio Contin"]
  spec.email         = ["contin@gmail.com"]
  spec.description   = 'Connect to Macquarie ESI web services'
  spec.summary       = 'Ruby Gem for extracting cash transactions from Macquarie ESI web service'
  spec.homepage      = "https://github.com/sharesight/jemquarie"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport", '~> 6.1', '>= 6.1.4.7'
  spec.add_runtime_dependency "rack", '~> 2.2'
  spec.add_runtime_dependency "savon", '~> 2.12'

  spec.add_development_dependency "rake", '~> 11.2'
  spec.add_development_dependency "rspec", '~> 3.4'
  spec.add_development_dependency "rubocop", '1.18.1'
  spec.add_development_dependency "warning"
  spec.add_development_dependency "webmock", '~> 3.3'
end
