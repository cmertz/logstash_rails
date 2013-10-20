require 'logstash_rails/formatter_base'

Dir[File.join(File.dirname(__FILE__), 'formatter', '*.rb')].each do |file|
  require file
end

module LogstashRails
  module Formatter

    def self.get(options = {})
      formatter = FormatterBase.new

      Formatter.constants.map do |constant|
        Formatter.const_get(constant)
      end.each do |decorator|
        decorator.decorate(formatter, options)
      end

      formatter
    end

  end
end
