describe LogstashRails::TransportBase do

  subject do
    LogstashRails
  end

  it 'raises if no transport is specified' do
    expect { subject.config({}) }.to raise_error(KeyError)
  end

  it 'handles all events by default' do
    config = subject.config(transport: :redis)

    expect(config).to receive(:push)

    ActiveSupport::Notifications.instrument('foobar_event')

    config.destroy
  end

  it 'logs exceptions if a logger is given' do
    logger = double(:logger)
    config = subject.config(transport: :redis, logger: logger)
    allow(config).to receive(:push).and_raise(ArgumentError.new)

    expect(logger).to receive(:error)

    ActiveSupport::Notifications.instrument('foobar_event')

    config.destroy
  end

end
