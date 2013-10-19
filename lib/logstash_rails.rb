require 'active_support'
require 'active_support/core_ext/string'


Dir[File.join(File.dirname(__FILE__), 'logstash_rails', '*.rb')].each do |file|
  require file
end

module LogstashRails

  #
  # configure LogstashRails
  #
  # @param options [Hash] configuration options
  #
  # @option options [Symbol] :transport The transport to use.
  # @option options [Array<String, Regexp>] :events The list of events to subscribe
  # @option options [Logger] :logger The logger for exceptions
  # @option options [Boolean] :flatten_params Flatten params hash of process_action.action_controller events (Hash with only one level). Defaults to true
  #
  # @return the configured transport
  #
  # @raise [KeyError] if no transport has been specified
  #
  # @see Transport available transports
  # @see TransportBase#destroy
  #
  def self.config(options)
    transport = options.fetch(:transport)
    transport = transport.to_s.camelize.to_sym

    formatter = LogstashRails::Formatter.get(options)

    LogstashRails::Transport.const_get(transport).new(formatter, options)
  end

end
