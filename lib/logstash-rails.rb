require 'logstash-rails/formatter'
require 'logstash-rails/redis'

module LogstashRails
  class << self

    def push(*args)
      Redis.push(Formatter.format(*args))
    end

  end
end
