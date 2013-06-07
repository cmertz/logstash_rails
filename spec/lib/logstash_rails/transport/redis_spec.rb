require 'spec_helper'

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

  it 'responds to #push' do
    subject.must_respond_to :push
  end

  it 'writes events to a redis list' do
    subject.push('foobar_event')

    Redis.new.lpop('logstash').must_equal 'foobar_event'
  end

end
