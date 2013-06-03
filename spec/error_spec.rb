require 'spec_helper'

describe 'error behaviour' do

  before do
    Redis::Connection::Memory.reset_all_databases
    LogstashRails.config(redis)
    ActiveSupport::Notifications.instrument("process_action.action_controller")
  end

  def redis
    Redis.new
  end

  it 'logs exception traces to the Rails logger' do
    skip

    Rails = Class.new do
      def self.logger
        @logger_mock ||= MiniTest::Mock.new
      end
    end

    Rails.logger.expect(:error, nil, [String])

    LogstashRails.config(1)

    ActiveSupport::Notifications.instrument("process_action.action_controller")
  end

  it 'survives weird event type names' do
    skip

    LogstashRails.config(redis)
    ActiveSupport::Notifications.instrument("!!!")
  end

end
