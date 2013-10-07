describe 'generated logstash event' do

  before do
    Redis::Connection::Memory.reset_all_databases
    LogstashRails.config(transport: :redis, redis: Redis.new, redis_key: 'logstash')
    ActiveSupport::Notifications.instrument("process_action.action_controller")
  end

  it 'is parsebale json' do
    JSON.parse(Redis.new.lpop('logstash'))
  end

  it 'has the event type as message' do
    JSON.parse(Redis.new.lpop('logstash'))['message'].should eq "process_action.action_controller"
  end

  it 'contains additional fields'

end
