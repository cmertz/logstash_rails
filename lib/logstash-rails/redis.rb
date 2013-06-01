module LogstashRails
  class Redis < Struct.new(:redis_connection, :key)
    def push(msg)
      raise unless redis_connection.rpush(key, msg)
    end
  end
end
