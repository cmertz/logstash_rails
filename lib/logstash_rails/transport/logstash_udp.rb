module LogstashRails
  module Transport
    class LogstashUdp < ConfigurationBase

      def initialize(options)
        super
        @socket = UDPSocket.new.tap{|s| s.connect(options.fetch(:host), options.fetch(:port)) }
      end

      def push(json_event)
        @socket.write(json_event)
      end

    end
  end
end
