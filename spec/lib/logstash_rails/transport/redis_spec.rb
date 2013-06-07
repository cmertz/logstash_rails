describe LogstashRails::Transport::Redis do

  before do
    Redis::Connection::Memory.reset_all_databases
  end

  subject do
    LogstashRails::Transport::Redis.new(
      redis:      Redis.new,
      redis_key: 'logstash'
    )
  end

  it { should respond_to :push }

  it 'writes events to a redis list' do
    subject.push('foobar_event')

    Redis.new.lpop('logstash').should eq 'foobar_event'
  end

end
