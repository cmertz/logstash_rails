# LogstashRails [![Code Climate](https://codeclimate.com/github/cmertz/logstash_rails.png)](https://codeclimate.com/github/cmertz/logstash_rails) [![Build Status](https://secure.travis-ci.org/cmertz/logstash_rails.png)](http://travis-ci.org/cmertz/logstash_rails) [![Dependency Status](https://gemnasium.com/cmertz/logstash_rails.png)](https://gemnasium.com/cmertz/logstash_rails) [![Coverage Status](https://coveralls.io/repos/cmertz/logstash_rails/badge.png)](https://coveralls.io/r/cmertz/logstash_rails)

Send Logstash events from a Rails application to Redis.

## Installation

In your applications Gemfile:

```ruby
gem 'logstash_rails'
```

For the latest version:

```ruby
gem 'logstash_rails', github: 'cmertz/logstash_rails'
```

Provide an initializer (e.g. config/initializers/logstash_rails.rb) for
specific configuration.

### Configuration

**LogstashRails.config** takes a redis connection, the redis key for the list
to push to and a flag that enables to catch all events (i.e. /.\*/)

The most basic configuration looks like:

```ruby
LogstashRails.config(Redis.new)
```

This will connect to the redis server on localhost, use 'logstash' (default) as
key for the redis list to push to and subscribe to all events.

A more complete example looks like:

```ruby
if Rails.env.production?
  redis = Redis.new(host: '1.2.3.4', port: 12345)
  LogstashRails.config(redis, 'my_key', false)
  LogstashRails.subscribe('process_action.action_controller')
end
```


## TODO

* more independent from Rails i.e. check defined?(Rails) and provide fallbacks (for logger and application name)
