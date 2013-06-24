module LogstashRails
  module Transport
    class Redis < TransportBase

      # @param options [Hash] configuration options
      #
      # @option options [Symbol] :host ('127.0.0.1') the host with the redis
      #   server
      # @option options [Symbol] :port (6379) the port to connect to
      # @option options [Symbol] :redis_key ('logstash') the key of the redis
      #   list to which events will be pushed to
      #
      def initialize(options)
        host = options[:host] || '127.0.0.1'
        port = options[:port] || 6379
        redis_key = options[:redis_key] || 'logstash'

        @redis = ::Redis.new(host: host, port: port)
        @redis_key = redis_key

        super
      end

      def push(json_event)
        begin
          unless @redis.rpush(@redis_key, json_event)
            raise "could not send event to redis"
          end
        rescue ::Redis::InheritedError
          @redis.client.connect
          retry
        end
      end

    end
  end
end
