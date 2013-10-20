module LogstashRails
  module Formatter
    module Source

      attr_writer :source

      def format(event_type, start, finish, id, payload)
        add_source(super)
      end

      private

      def add_source(event_hash)
        event_hash.merge!(source: source)
      end

      def source
        @source ||= if defined?(Rails)
          Rails.application.class.parent_name
        end || ''
      end

    end
  end
end
