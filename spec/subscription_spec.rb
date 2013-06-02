require 'spec_helper'

describe LogstashRails do

  before do
    Redis::Connection::Memory.reset_all_databases
  end

  def redis
    Redis.new
  end

  it 'handles all events by default' do
    LogstashRails.config(redis)

    ActiveSupport::Notifications.instrument("process_action.action_controller")

    redis.lpop('logstash').wont_be_nil
  end

  it 'does not handle unknown events' do
    LogstashRails.config(redis)

    ActiveSupport::Notifications.instrument("toto")

    redis.lpop('logstash').must_be_nil
  end

  it 'does not handle events unless told to' do
    LogstashRails.config(redis, 'logtstash', false)

    ActiveSupport::Notifications.instrument("process_action.action_controller")

    redis.lpop('logstash').must_be_nil
  end

  it 'handles events explicitly subscribed to' do
    LogstashRails.config(redis, 'logstash', false)
    LogstashRails.subscribe("process_action.action_controller")

    ActiveSupport::Notifications.instrument("process_action.action_controller")

    redis.lpop('logstash').wont_be_nil
  end

  it 'can be unsubscribed from events' do
    LogstashRails.config(redis, 'logtstash', false)
    LogstashRails.subscribe("process_action.action_controller")
    LogstashRails.unsubscribe("process_action.action_controller")

    ActiveSupport::Notifications.instrument("process_action.action_controller")

    redis.lpop('logstash').must_be_nil
  end

  it 'uses the provided redis key' do
    LogstashRails.config(redis, 'foorediskey', false)
    LogstashRails.subscribe("process_action.action_controller")

    ActiveSupport::Notifications.instrument("process_action.action_controller")

    redis.lpop('foorediskey').wont_be_nil
  end

end
