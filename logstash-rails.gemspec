lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'logstash-rails/version'

Gem::Specification.new do |gem|
  gem.name          = "logstash-rails"
  gem.version       = LogstashRails::VERSION
  gem.authors       = ["cmertz"]
  gem.email         = ["chris@nimel.de"]
  gem.description   = %q{Send Logstash events from a Rails application to Redis}
  gem.summary       = %q{Send Logstash events from a Rails application to Redis}
  gem.homepage      = ""
  gem.license       = "GPL"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('logstash-event')
  gem.add_dependency('redis')

  gem.add_development_dependency('test-unit')
  gem.add_development_dependency('rails')
end
