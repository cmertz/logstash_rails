require 'logstash-rails/formatter'
require 'logstash-rails/redis'

module LogstashRails

  def self.test=(value)
    raise ArgumentError unless value == true || value == false
    @test = value
  end

  def self.test?
    @test
  end

  def self.push(*args)
    Redis.push(Formatter.format(*args))
  end

end
