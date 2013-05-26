require 'yaml'

module LogstashRails
  Redis = Class.new do

    DEFAULT_CONFIG_FILE = 'config/logstash-rails.yml'

    def initialize
      config = YAML.load_file(DEFAULT_CONFIG_FILE)

      @key   = config.delete('key')
      @redis = Redis.connect(config)
    end

    def push(msg)
      raise unless @redis.rpush(@key, msg)
    end

  end.new
end
