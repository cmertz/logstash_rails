module LogstashRails
  module Formatter
    module Source

      attr_accessor :source

      def format(event_type, start, finish, id, payload)
        add_source(super)
      end

      def self.decorate(target, options)
        source = options[:source]
        if source != false
          target.extend(self)
          target.source = get_source(source)
        end
      end

      private

      def self.get_source(source_option)
        if source_option != true
          source_option
        else
          if defined?(Rails)
            Rails.application.class.parent_name
          else
            ''
          end
        end
      end

      def add_source(event_hash)
        event_hash.merge!(source: source)
      end

    end
  end
end
