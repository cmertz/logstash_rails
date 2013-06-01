require 'logstash-rails/formatter'
require 'logstash-rails/redis'

module LogstashRails
  def self.push(*args)
    Redis.push(Formatter.format(*args))
  end
end
