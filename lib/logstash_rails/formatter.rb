require 'logstash-event'
require 'socket'

module LogstashRails
  class Formatter

    def initialize(options = {})
      @flatten_params = options[:flatten_params]
    end

    def format(event_type, start, finish, id, payload)
      payload.merge!(
        process_id: $$,
        host: Socket.gethostname
      )

      # process_action.action_controller events
      # from Rails4 contain Rack::Request instances
      # that are not serializable
      payload.delete(:request)

      payload = flatten_params(payload) if @flatten_params

      event = LogStash::Event.new(payload)

      event.timestamp = start
      event.message   = event_type
      event.source    = application_name

      event.to_json
    end

    private

    def flatten_params(h, last = nil, accu = {})
      h.each do |k, v|
        prefix = "#{last}_#{k}"
        if v.is_a?(Hash)
          flatten_params(v, prefix, accu)
        else
          accu[prefix] = v
        end
      end

      accu
    end

    def application_name
      if defined?(Rails)
        Rails.application.class.parent_name
      end
    end

  end
end
