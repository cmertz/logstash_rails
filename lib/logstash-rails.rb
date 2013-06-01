require 'logstash-rails/formatter'
require 'logstash-rails/redis'

module LogstashRails
  class << self

    def subscribe(event_type)
      @subscriptions ||= {}

      @subscriptions[event_type] = ActiveSupport::Notifications.subscribe(event_type) do |*args|
        push(*args)
      end
    end

    def unsubscribe(event_type)
      ActiveSupport::Notifications.unsubscribe(@subscriptions[event_type])
    end

    def push(*args)
      Redis.push(Formatter.format(*args))
    end

  end
end
