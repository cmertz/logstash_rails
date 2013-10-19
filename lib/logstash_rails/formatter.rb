require 'logstash_rails/formatter_base'

Dir[File.join(File.dirname(__FILE__), 'formatter', '*.rb')].each do |file|
  require file
end

module LogstashRails
  module Formatter

    def self.get(options = {})
      formatter = FormatterBase.new(options)
      formatter.extend(FlattenParams)
      formatter
    end

  end
end
