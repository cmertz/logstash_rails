require 'logstash-rails/formatter'
require 'active_support'

module LogstashRails
  class << self

    def config(redis, key = 'logstash', handle_all = true)
      @redis = redis
      @key   = key

      self.handle_all = handle_all
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

    def push(event_type, *args)
      return unless Formatter.can_handle?(event_type)
      raise unless @redis.rpush(@key, Formatter.format(event_type, *args))
    end

    private

    def handle_all=(value)
      unless value.is_a?(TrueClass) || value.is_a?(FalseClass)
        raise ArgumentError
      end

      @handle_all = value

      subscribe(/.*/)
    end

  end
end
