require 'logstash-event'

module LogstashRails

  class FormatterBase

    def perform(event_type, start, finish, id, payload)
      event_hash = format(event_type, start, finish, id, payload)

      event = LogStash::Event.new(event_hash)

      event.timestamp = start

      event.to_json
    end

    def format(event_type, start, finish, id, payload)
      payload.clone
    end

  end
end
