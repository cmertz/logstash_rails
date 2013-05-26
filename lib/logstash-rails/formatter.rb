require 'logstash-event'
require 'socket'

Dir["#{File.dirname(__FILE__)}/formatter/*.rb"].each do |file|
  require file
end

module LogstashRails
  module Formatter

    def self.format(name, start, finish, id, payload)
      event = LogStash::Event.new

      event.timestamp = start
      event.source = Socket.gethostname

      event.fields['pid'] = $$
      event.fields['id']  = id

      formatter = const_get(name.gsub('.','_').camelize.to_sym)
      formatter.format(event, payload)

      event.to_json
    end

  end
end
