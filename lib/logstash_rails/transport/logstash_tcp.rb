require 'celluloid/io'

module LogstashRails
  module Transport
    class LogstashTcp < TransportBase

      def initialize(options)
        @host = options[:host] || 'localhost'
        @port = options.fetch(:port)

        super
      end

      def push(json_event)
        @socket.write(json_event)
      rescue Errno::EPIPE, Errno::ECONNREFUSED, NoMethodError => e
        log(e)
        connect!
        retry
      end

      def destroy
        super
        @socket.close
      end

      private

      def connect!
        @socket = Celluloid::IO::TCPSocket.new(@host, @port)
      end

    end
  end
end
