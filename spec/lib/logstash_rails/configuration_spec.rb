describe LogstashRails::Configuration do

  subject do
    LogstashRails::Configuration
  end

  it 'raises if no transport is specified' do
    expect { subject.new({}) }.to raise_error(KeyError)
  end

  it 'handles all events by default' do
    redis_transport = mock(:redis)
    LogstashRails::Transport::Redis.stub(:new).and_return(redis_transport)
    config = subject.new(transport: :redis)

    redis_transport.should_receive(:push)

    ActiveSupport::Notifications.instrument('foobar_event')

    config.destroy
  end

  it 'logs exceptions if a logger is given' do
    logger = mock(:logger)
    LogstashRails::Transport::Redis.stub(:new).and_return(nil)
    config = subject.new(transport: :redis, logger: logger)

    logger.should_receive(:error)

    ActiveSupport::Notifications.instrument('foobar_event')

    config.destroy
  end

end
