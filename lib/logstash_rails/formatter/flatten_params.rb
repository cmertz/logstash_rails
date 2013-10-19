module LogstashRails
  module Formatter
    module FlattenParams

      private

      def flatten_params(payload)
        return unless @flatten_params

        params = payload[:params]
        return unless params

        payload[:params] = flatten_hash(params)
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
