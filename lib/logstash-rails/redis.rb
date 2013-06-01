module LogstashRails
  class Redis < Struct.new(:redis_connection, :key)
    def push(msg)
      raise unless @redis.rpush(@key, msg)
    end
  end
end
