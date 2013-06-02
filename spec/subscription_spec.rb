require 'spec_helper'

describe 'generated logstash event' do

  before do
    Redis::Connection::Memory.reset_all_databases
    LogstashRails.config(redis)
    ActiveSupport::Notifications.instrument("process_action.action_controller")
  end

  def redis
    Redis.new
  end

  it 'is parsebale json' do
    JSON.parse(redis.lpop('logstash'))
  end

  it 'has the event type as message' do
    JSON.parse(redis.lpop('logstash'))['@message'].must_equal "process_action.action_controller"
  end

end
