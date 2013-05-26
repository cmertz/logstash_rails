module LogstashRails
  class Railtie < Rails::Railtie
    initializer 'logstash-rails' do
      ActiveSupport::Notifications.subscribe "process_action.action_controller" do |*args|
        LogstashRails.push(*args)
      end
    end
  end
end
