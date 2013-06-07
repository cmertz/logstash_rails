require 'logstash_rails/formatter'
require 'active_support'

module LogstashRails
  extend self

  # configures LogstashRails
  #
  # @param redis
  # @param key [String]
  # @param handle_all [Boolean]
  #
  def config(redis, key = 'logstash', handle_all = true)
    unless handle_all.is_a?(TrueClass) || handle_all.is_a?(FalseClass)
      raise ArgumentError
    end

    raise ArgumentError unless key.is_a?(String)

    raise ArgumentError unless redis

    @redis = redis
    @key   = key

    subscribe(/.*/) if handle_all
  end

  # subscribes LogstashRails to an ActiveSupport notification
  #
  # @param event_type [String|Regexp]
  #
  def subscribe(event_type)
    @subscriptions ||= {}

    @subscriptions[event_type] = ActiveSupport::Notifications.subscribe(event_type) do |*args|
      push(*args)
    end
  end

  private

  def push(event_type, *args)
    begin
      @redis.rpush(@key, Formatter.format(event_type, *args))
    rescue
      log $!
    end
  end

  def log(exception)
    msg = exception.message + "\n " + exception.backtrace.join("\n ")
    Rails.logger.error(msg)
  end

end
