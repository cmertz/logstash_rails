describe LogstashRails::Transport::Redis do

  before do
    Redis::Connection::Memory.reset_all_databases
  end

  subject do
    formatter = LogstashRails::Formatter.get
    LogstashRails::Transport::Redis.new(
      formatter,
      redis:      Redis.new,
      redis_key: 'logstash',
      raise_errors: true
    )
  end

  it { should respond_to :push }

  it 'writes events to a redis list' do
    subject.push('foobar_event')

    Redis.new.lpop('logstash').should eq 'foobar_event'
  end

  it 'survives forking', forking: true do
    r,w = IO.pipe

    # use connection in parent process
    subject.push 'foo'
    Redis.new.lpop 'logstash'

    fork do
      # use connection in child process
      subject.push 'bar'

      w.write(Redis.new.lpop('logstash') == 'bar')
      w.flush

      # override exit hooks
      SimpleCov.at_exit{}
      Process.exit! true
    end

    w.close

    r.read.should eq 'true'

    Process.wait
  end

end
