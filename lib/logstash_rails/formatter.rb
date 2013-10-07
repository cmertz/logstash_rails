require 'logstash-event'
require 'socket'

module LogstashRails

  # TODO needs refactoring
  class Formatter

    def initialize(options = {})
      @flatten_params = (options[:flatten_params] != false)
    end

    def format(event_type, start, finish, id, payload)
      payload.merge!(
        process_id: $$,
        host:       Socket.gethostname,
        message:    event_type,
        source:     application_name
      )

      # process_action.action_controller events
      # from Rails4 contain Rack::Request instances
      # that are not serializable
      payload.delete(:request)

      flatten_params(payload)

      event = LogStash::Event.new(payload)

      event.timestamp = start

      event.to_json
    end

    private

    def flatten_params(payload)
      return unless @flatten_params

      params = payload[:params]
      return unless params

      payload[:params] = flatten_hash(params)
    end

    def prefix(current, last)
      return "#{last}__#{current}" if last

      current.to_s
    end

    def flatten_hash(h, last = nil, accu = {})
      h.each do |k, v|
        prefix = prefix(k, last)

        if v.is_a?(Hash)
          flatten_hash(v, prefix, accu)
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
