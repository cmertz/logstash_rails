# LogstashRails 
[![Gem Version](https://badge.fury.io/rb/logstash_rails.png)](http://badge.fury.io/rb/logstash_rails)
[![Build Status](https://secure.travis-ci.org/cmertz/logstash_rails.png)](http://travis-ci.org/cmertz/logstash_rails)
[![Coverage Status](https://coveralls.io/repos/cmertz/logstash_rails/badge.png)](https://coveralls.io/r/cmertz/logstash_rails)
[![Code Climate](https://codeclimate.com/github/cmertz/logstash_rails.png)](https://codeclimate.com/github/cmertz/logstash_rails)
[![Dependency Status](https://gemnasium.com/cmertz/logstash_rails.png)](https://gemnasium.com/cmertz/logstash_rails)

Send events from Rails to Logstash without logger foo.

## Contents

* [Usage](#usage)
    * [Configuration](#configurtion)
    * [Examples](#examples)
* [Contributing](#contributing)


## Usage

Add logstash-rails to your applications `Gemfile`

```ruby
gem 'logstash_rails'
```

and provide an initializer for configuration.


### Configuration

`LogstashRails.config` takes an options hash with the following options:

* __transport__
  
  redis is the only available transport atm

* __logger__
  
  logger to use in case of exceptions while pushing events to the transport

* __events__

  list of event name patterns to subscribe to. `Regex` and `String` is
  supported.
  
* __transport options__

  transport specific options e.g. _host_, _port_ and *redis_key*


### Examples

The most basic configuration looks like:

```ruby
LogstashRails.config(transport: :redis)
```

This will will connect to a redis server on _localhost:6379_, use _logstash_ as
key for the redis list to push to and subscribe to _all events_.

A more complete example looks like:

```ruby
if Rails.env.production?
  LogstashRails.config(
    transport: redis,
    host: '1.2.3.4', 
    port: 12345,
    redis_key: 'my_key',
    events: [/action_controller/]
  )
end
```

This will only subscribe to events from `ActionController`.


## Contributing

1. Fork it.
2. Create a branch (`git checkout -b my_feature`)
3. Commit your changes (`git commit -am "Added ..."`)
4. Push to the branch (`git push origin my_feature`)
5. Open a Pull Request
6. Enjoy a refreshing Diet Coke and wait
