module LogstashRails
  module Formatter
    class ProcessActionActionController

      def self.format(event, payload)
        event.fields['http_verb']  = payload[:method]
        event.fields['controller'] = payload[:controller]
        event.fields['action']     = payload[:action]
        event.fields['path']       = payload[:path]
        event.fields['status']     = payload[:status]
        event.fields['params']     = payload[:params]
      end

    end
  end
end
