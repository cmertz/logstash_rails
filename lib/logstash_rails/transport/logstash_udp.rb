module LogstashRails
  module Transport
    class LogstashUdp < TransportBase

      def initialize(options = {})
        host = options[:host] || 'localhost'
        port = options[:port] || 9999

        @socket = UDPSocket.new.tap{|s| s.connect(host, port) }

        super
      end

      def push(json_event)
        @socket.write(json_event)
      end

    end
  end
end
