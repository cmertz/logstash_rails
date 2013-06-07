# LogstashRails [![Code Climate](https://codeclimate.com/github/cmertz/logstash_rails.png)](https://codeclimate.com/github/cmertz/logstash_rails) [![Build Status](https://secure.travis-ci.org/cmertz/logstash_rails.png)](http://travis-ci.org/cmertz/logstash_rails) [![Dependency Status](https://gemnasium.com/cmertz/logstash_rails.png)](https://gemnasium.com/cmertz/logstash_rails) [![Coverage Status](https://coveralls.io/repos/cmertz/logstash_rails/badge.png)](https://coveralls.io/r/cmertz/logstash_rails)

Send events from Rails to Logstash without logger foo.

## Installation

Add logstash-rails to your applications `Gemfile`

```ruby
gem 'logstash_rails'
```

and provide an initializer for configuration.

### Configuration

`LogstashRails.config` takes an options hash with the following options:

* transport
  redis is the only available transport atm
* logger
  logger to use in case of exceptions while pushing events to the transport
* events
  list of event name patterns to subscribe to. `Regex` and `String` is
  supported.

The most basic configuration looks like:

```ruby
LogstashRails.config(transport: :redis, redis: Redis.new)
```

This will will use the provided redis connection, 'logstash' as
key for the redis list to push to and subscribe to all events.

A more complete example looks like:

```ruby
if Rails.env.production?
  LogstashRails.config(
    transport: redis,
    redis: Redis.new(host: '1.2.3.4', port: 12345)
    redis_key: 'my_key',
    events [/action_controller/]
  )
end
```

This will only subscribe to events from `ActionController`.
