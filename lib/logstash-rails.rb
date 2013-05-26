require 'logstash-rails/formatter'
require 'logstash-rails/redis'
require 'logstash-rails/railtie' if defined?(Rails)

module LogstashRails

  def self.push(*args)
    Redis.push(Formatter.format(*args))
  end

end
