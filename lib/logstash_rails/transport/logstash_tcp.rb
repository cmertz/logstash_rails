module LogstashRails
  module Transport
    class LogstashTcp < ConfigurationBase

      def initialize(options)
        super

        host = options[:host] || 'localhost'
        port = options.fetch(:port)

        @socket = TCPSocket.new(host, port)
      end

      def push(json_event)
        @socket.write(json_event)
      end

    end
  end
end
