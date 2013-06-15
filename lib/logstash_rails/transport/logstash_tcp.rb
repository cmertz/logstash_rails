module LogstashRails
  module Transport
    class LogstashTcp < TransportBase

      def initialize(options)
        super

        host = options[:host] || 'localhost'
        port = options.fetch(:port)

        @socket = TCPSocket.new(host, port)
      end

      def push(json_event)
        @socket.write(json_event)
      end

      def destroy
        super
        @socket.close
      end

    end
  end
end
