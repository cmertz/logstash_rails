require 'coveralls'
require 'simplecov'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start do
  add_filter('spec')
end

require 'bundler'
Bundler.require

require 'logstash_rails'

if RUBY_ENGINE == 'jruby'
  RSpec.configure do |c|
    c.filter_run_excluding forking: true
  end
end
