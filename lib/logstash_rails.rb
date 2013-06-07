require 'active_support'
require 'active_support/core_ext/string'

Dir[File.join(File.dirname(__FILE__), 'logstash_rails', '*.rb')].each do |file|
  require file
end

module LogstashRails
  extend self

  def config(options)
    Configuration.new(options)
  end

end
