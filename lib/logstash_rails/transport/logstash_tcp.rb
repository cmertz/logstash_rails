require 'celluloid/io'
require 'celluloid/io'

module LogstashRails
  module Transport
    class LogstashTcp < TransportBase

      def initialize(options)
        @host = options[:host] || 'localhost'
        @port = options.fetch(:port)

        connect!

        super
      end

      def push(json_event)
        write(json_event)
      rescue Errno::EPIPE, Errno::ECONNREFUSED => e
        log e
        connect!
        write(json_event)
      end

      def write(json_event)
        connect! unless @socket
        @socket.write(json_event) if @socket
      end

      def destroy
        super
        @socket.close
      end

      private

      def connect!
        @socket = Celluloid::IO::TCPSocket.new(@host, @port)
      rescue Errno::ECONNREFUSED => e
        log e
      end

    end
  end
end
