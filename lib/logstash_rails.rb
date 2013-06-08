require 'active_support'
require 'active_support/core_ext/string'

require 'logstash_rails/configuration_base'

Dir[File.join(File.dirname(__FILE__), 'logstash_rails', '*.rb')].each do |file|
  require file
end

module LogstashRails
  extend self

  def config(options)
    transport = options.fetch(:transport)
    transport = transport.to_s.camelize.to_sym

    LogstashRails::Transport.const_get(transport).new(options)
  end

end
