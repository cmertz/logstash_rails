require 'active_support'
require 'active_support/core_ext/string'

require 'logstash_rails/transport_base'

Dir[File.join(File.dirname(__FILE__), 'logstash_rails', '*.rb')].each do |file|
  require file
end

module LogstashRails

  #
  # @param options [Hash] configuration options
  #
  # @option options [Symbol] :transport The transport to use.
  # @option options [Array<String, Regexp>] :events The list of events to subscribe
  # @option options [Logger] :logger The logger for exceptions
  #
  # @returns the configured transport
  #
  # @see Transport available transports
  # @see TransportBase#destroy
  #
  def self.config(options)
    transport = options.fetch(:transport)
    transport = transport.to_s.camelize.to_sym

    LogstashRails::Transport.const_get(transport).new(options)
  end

end
