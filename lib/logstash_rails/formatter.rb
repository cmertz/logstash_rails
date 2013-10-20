require 'logstash_rails/formatter_base'

Dir[File.join(File.dirname(__FILE__), 'formatter', '*.rb')].each do |file|
  require file
end

module LogstashRails
  module Formatter

    def self.get(options = {})
      formatter = FormatterBase.new

      if options[:flatten_params] != false
        formatter.extend(FlattenParams)
      end

      source = options[:source]
      if source != false
        formatter.extend(Source)
        if source != true
          formatter.source = source
        end
      end

      formatter
    end

  end
end
