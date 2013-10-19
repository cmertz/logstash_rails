require 'logger'

module LogstashRails
  module Transport
    class Logfile < TransportBase

      def initialize(formatter, options = {})
        logfile  = options[:logfile] || 'log/logstash_rails.log'

        @logger = ::Logger.new(logfile)
        @logger.formatter = lambda do |severity, datetime, progname, msg|
          "#{msg}\n"
        end
        @logger.level = Logger::INFO

        super
      end

      def push(json_event)
        @logger.info(json_event)
      end

    end
  end
end
