require 'spec_helper'

describe LogstashRails::Configuration do
  i_suck_and_my_tests_are_order_dependent!

  subject do
    LogstashRails::Configuration
  end

  it 'raises if no transport is specified' do
    lambda { subject.new({}) }.must_raise(KeyError)
  end

  it 'handles all events by default' do
    mock = Minitest::Mock.new

    LogstashRails::Transport::Redis.stub(:new, mock) do
      subject.new(transport: :redis)
    end

    mock.expect(:push, nil, [String])
    ActiveSupport::Notifications.instrument('foobar_event')

    mock.verify
  end

  it 'logs exceptions if a logger is given' do
    logger = Minitest::Mock.new
    logger.expect(:error, nil, [String])

    LogstashRails::Transport::Redis.stub(:new, nil) do
      subject.new(transport: :redis, logger: logger)
    end

    ActiveSupport::Notifications.instrument('foobar_event')

    logger.verify
  end

end
