require 'spec_helper'
require 'mocha/setup'

describe 'error behaviour' do

  it 'logs exception traces to the Rails logger' do
    logger = MiniTest::Mock.new
    logger.expect(:error, nil, [String])
    LogstashRails.stubs(:log).returns(logger)

    LogstashRails.config(1)

    ActiveSupport::Notifications.instrument("process_action.action_controller")
  end

end
