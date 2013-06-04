require 'spec_helper'
require 'mocha/setup'

describe 'error behaviour' do

  it 'logs exception traces to the Rails logger' do
    Rails = Object.new
    Rails.stubs(:logger).returns(MiniTest::Mock.new)
    Rails.logger.expect(:error, nil, [String])

    LogstashRails.config(1)

    ActiveSupport::Notifications.instrument("process_action.action_controller")
  end

end
