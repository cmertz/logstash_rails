module LogstashRails
  module Transport
    class LogstashTcp < ConfigurationBase

      def initialize(options)
        super
        @socket = TCPSocket.new(options.fetch(:host), options.fetch(:port))
      end

      def push(json_event)
        @socket.write(json_event)
      end

    end
  end
end
