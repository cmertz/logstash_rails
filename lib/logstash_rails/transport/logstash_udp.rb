module LogstashRails
  module Transport
    class LogstashUdp < ConfigurationBase

      def initialize(options = {})
        super

        host = options[:host] || 'localhost'
        port = options[:port] || 9999

        @socket = UDPSocket.new.tap{|s| s.connect(host, port) }
      end

      def push(json_event)
        @socket.write(json_event)
      end

    end
  end
end
