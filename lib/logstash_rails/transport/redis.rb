module LogstashRails
  module Transport
    class Redis < Struct.new(:redis, :redis_key)

      def initialize(options)
        self.redis     = options.fetch(:redis)
        self.redis_key = options.fetch(:redis_key)
      end

      def push(json_event)
        unless redis.rpush(redis_key, json_event)
          raise "could not send event to redis"
        end
      end

    end
  end
end
