module LogstashRails
  module Transport
    class Redis < LogstashRails::ConfigurationBase

      def initialize(options)
        host = options[:host] || '127.0.0.1'
        port = options[:port] || 6379
        redis_key = options[:redis_key] || 'logstash'

        @redis = ::Redis.new(host: host, port: port)
        @redis_key = redis_key

        super
      end

      def push(json_event)
        unless @redis.rpush(@redis_key, json_event)
          raise "could not send event to redis"
        end
      end

    end
  end
end
