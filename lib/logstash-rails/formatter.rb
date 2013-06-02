require 'logstash-event'
require 'socket'
require 'active_support/core_ext/string/inflections'

Dir["#{File.dirname(__FILE__)}/formatter/*.rb"].each do |file|
  require file
end

module LogstashRails
  module Formatter

    def self.format(event_type, *args)
      json_event(event_type, *args)
    end

    private

    def self.json_event(event_type, start, finish, id, payload)
      event = LogStash::Event.new

      event.message   = event_type
      event.timestamp = start
      event.source = Socket.gethostname

      event.fields['pid'] = $$
      event.fields['id']  = id

      formatter(event_type).format(event, payload)

      event.to_json
    end

    def self.formatter(event_type)
      const_get(event_type.gsub('.','_').camelize.to_sym)
    end

    def self.can_handle?(event_type)
      const_defined?(event_type.gsub('.','_').camelize.to_sym)
    end

  end
end
