require 'logstash_rails/formatter_base'

module LogstashRails
  module Formatter

    def self.get(options = {})
      FormatterBase.new(options)
    end

  end
end
