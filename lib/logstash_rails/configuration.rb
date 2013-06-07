module LogstashRails
  class Configuration < Struct.new(:events, :transport, :logger)

    def initialize(options)
      transport = options.fetch(:transport)

      self.events = options[:events] || [/.*/]
      self.transport = LogstashRails::Transport.get(transport).new(options)
      self.logger = options[:logger]

      subscribe
    end

    def destroy
      return unless @subscriptions

      @subscriptions.each do |subscription|
        ActiveSupport::Notifications.unsubscribe(subscription)
      end
    end

    private

    def subscribe
      @subscriptions = events.map do |event|
        ActiveSupport::Notifications.subscribe(event) do |*args|
          json_event = Formatter.format(*args)

          begin
            transport.push(json_event)
          rescue
            log($!)
          end
        end
      end
    end

    def log(exception)
      msg = exception.message + "\n " + exception.backtrace.join("\n ")
      logger.error(msg) if logger
    end

  end
end
