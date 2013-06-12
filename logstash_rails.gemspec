lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'logstash_rails/version'

Gem::Specification.new do |gem|
  gem.name          = "logstash_rails"
  gem.version       = LogstashRails::VERSION
  gem.authors       = ["cmertz"]
  gem.email         = ["chris@nimel.de"]
  gem.summary       = %q{Send events from Rails to Logstash without logger foo.}
  gem.description   = %q{Send events from Rails to Logstash without logger foo.}
  gem.homepage      = "https://github.com/cmertz/logstash_rails"
  gem.license       = "GPL"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^spec/})
  gem.require_paths = ["lib"]

  gem.add_dependency('logstash-event')
  gem.add_dependency('activesupport')
  gem.add_dependency('redis')
end
