require 'logstash-rails/formatter'
require 'logstash-rails/redis'
require 'active_support'

module LogstashRails
  class << self

    def handle_all?
      @handle_all
    end

    def handle_all=(value)
      unless value.is_a?(TrueClass) || value.is_a?(FalseClass)
        raise ArgumentError
      end

      @handle_all = value

      subscribe(/.*/) if handle_all?
    end

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
