module LogstashRails
  module Formatter
    module FlattenParams

      def format(event_type, start, finish, id, payload)
        flatten_params(super)
      end

      def self.decorate(target, options)
        if options[:flatten_params] != false
          target.extend(self)
        end
      end

      private

      def flatten_params(event_hash)
        params = event_hash[:params]
        return event_hash unless params

        event_hash[:params] = flatten_hash(params)

        event_hash
      end

      def prefix(current, last)
        return "#{last}__#{current}" if last

        current.to_s
      end

      def flatten_hash(h, last = nil, accu = {})
        h.each do |k, v|
          prefix = prefix(k, last)

          if v.is_a?(Hash)
            flatten_hash(v, prefix, accu)
          else
            accu[prefix] = v
          end
        end

        accu
      end

    end
  end
end
