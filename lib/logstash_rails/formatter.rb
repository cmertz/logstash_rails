require 'logstash-event'
require 'socket'

module LogstashRails
  class Formatter

    def format(event_type, start, finish, id, payload)
      payload.merge!(
        process_id: $$,
        host: Socket.gethostname
      )

      # process_action.action_controller events
      # from Rails4 contain Rack::Request instances
      # that are not serializable
      payload.delete(:request)

      event = LogStash::Event.new(payload)

      event.timestamp = start
      event.message   = event_type
      event.source    = application_name

      event.to_json
    end

    private

    def application_name
      if defined?(Rails)
        Rails.application.class.parent_name
      end
    end

  end
end
