require 'logstash-event'
require 'socket'

module LogstashRails

  class FormatterBase

    def perform(event_type, start, finish, id, payload)
      event_hash = format(event_type, start, finish, id, payload)

      event = LogStash::Event.new(event_hash)

      event.timestamp = start

      event.to_json
    end

    def format(event_type, start, finish, id, payload)
      payload = payload.merge(
        process_id: $$,
        host:       Socket.gethostname,
        message:    event_type
      )

      # process_action.action_controller events
      # from Rails4 contain Rack::Request instances
      # that are not serializable
      payload.delete(:request)

      payload
    end

  end
end
