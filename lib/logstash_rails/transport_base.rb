module LogstashRails

  # base class for transports
  class TransportBase

    # @see LogstashRails.config
    def initialize(options)
      @events = options[:events] || [/.*/]
      @error_logger = options[:logger]

      if defined?(Rails)
        @error_logger ||= Rails.logger
      end

      subscribe
    end

    # destroy
    #
    # unsubscribe from ActiveSupport::Notifications
    #
    def destroy
      return unless @subscriptions

      @subscriptions.each do |subscription|
        ActiveSupport::Notifications.unsubscribe(subscription)
      end
    end

    private

    def subscribe
      @subscriptions = @events.map do |event|
        ActiveSupport::Notifications.subscribe(event, method(:event_handler))
      end
    end

    def event_handler(*args)
      json_event = Formatter.format(*args)

      begin
        push(json_event)
      rescue
        log($!)
      end
    end

    def log(exception)
      return unless @error_logger
      @error_logger.error(exception.message + "\n " + exception.backtrace.join("\n "))
    end

  end
end
