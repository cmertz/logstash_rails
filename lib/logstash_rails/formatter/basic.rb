require 'socket'

module LogstashRails
  module Formatter
    module Basic

      def self.decorate(target, options)
        target.extend(self)
      end

      def format(event_type, start, finish, id, payload)
        event_hash = super

        event_hash.merge!(
          process_id: $$,
          host:       Socket.gethostname,
          message:    event_type
        )

        # process_action.action_controller events
        # from Rails4 contain Rack::Request instances
        # that are not serializable
        event_hash.delete(:request)

        event_hash
      end

    end
  end
end
