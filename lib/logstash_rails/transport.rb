require 'logstash_rails/transport_base'

Dir[File.join(File.dirname(__FILE__), 'transport', '*.rb')].each do |file|
  require file
end

module LogstashRails
  module Transport
    def self.get(transport)
      constant_name = transport.to_s.camelize.to_sym
      LogstashRails::Transport.const_get(constant_name)
    end
  end
end
