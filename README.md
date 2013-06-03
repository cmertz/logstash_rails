# LogstashRails [![Code Climate](https://codeclimate.com/github/cmertz/logstash_rails.png)](https://codeclimate.com/github/cmertz/logstash_rails) [![Build Status](https://secure.travis-ci.org/cmertz/logstash_rails.png)](http://travis-ci.org/cmertz/logstash_rails) [![Dependency Status](https://gemnasium.com/cmertz/logstash_rails.png)](https://gemnasium.com/cmertz/logstash_rails) [![Coverage Status](https://coveralls.io/repos/cmertz/logstash_rails/badge.png)](https://coveralls.io/r/cmertz/logstash_rails)

Send Logstash events from a Rails application to Redis.


## Usage

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

* extend README
* add formatter for more events (e.g. actionmailer, actionview, ...)
* write log entry in case we cannot push to redis
* add doc task to Rakefile
