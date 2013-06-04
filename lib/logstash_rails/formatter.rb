require 'logstash-event'
require 'socket'

module LogstashRails
  module Formatter

    def self.format(event_type, *args)
      json_event(event_type, *args)
    end

    private

    def self.argument_hash(event_type, start, finish, id, payload)
      {
        process_id: $$,
        message: event_type,
        source: Socket.gethostname
      }.merge!(payload)
    end

    def self.json_event(event_type, start, finish, id, payload)
      event = LogStash::Event.new(argument_hash(event_type, start, finish, id, payload))

      event.timestamp = start

      event.to_json
    end

  end
end
