# LogstashRails
[![Gem Version](https://badge.fury.io/rb/logstash_rails.png)](http://badge.fury.io/rb/logstash_rails)
[![Build Status](https://secure.travis-ci.org/cmertz/logstash_rails.png)](http://travis-ci.org/cmertz/logstash_rails)
[![Coverage Status](https://coveralls.io/repos/cmertz/logstash_rails/badge.png)](https://coveralls.io/r/cmertz/logstash_rails)
[![Code Climate](https://codeclimate.com/github/cmertz/logstash_rails.png)](https://codeclimate.com/github/cmertz/logstash_rails)
[![Dependency Status](https://gemnasium.com/cmertz/logstash_rails.png)](https://gemnasium.com/cmertz/logstash_rails)

Send events from Rails to Logstash without logger foo.

LogstashRails uses `ActiveSupport::Notifications` to subscribe to events from *Rails* and push them to *Logstash*.
It emmits json formatted `Logstash::Event`.

There is no `Logger` configuration, logfile or filter in Logstash required.

## Contents
* [Features](#features)
* [Platforms](#platforms)
* [Usage](#usage)
    * [API](#api)
    * [Configuration](#configuration)
    * [Examples](#examples)
* [Contributing](#contributing)

## Features

* fine grained control over which events will be subscribed to
* some json event format normalization to prevent troubles with `Elasticsearch`
* can be reconfigured at runtime
* tcp and udp transports for testing

## Platforms

Tested under CRuby 1.9.3 and 2.0 . See [travis builds](http://travis-ci.org/cmertz/logstash_rails) for more details.


## Usage

Add logstash-rails to your applications `Gemfile`

```ruby
gem 'logstash_rails'
```

and provide an initializer for configuration.

You will have to add redis as a dependency to your application in order to use the redis transport.

### API

`LogstashRails.configure(options_hash)` returns an configured instance of `LogstashRails::Transport`.
See [Configuration](#configuration) for the options.

`LogstashRails::Transport#destroy` releases all resources (e.g. closes sockets) and unsubscribes 
from all events for this instance.


### Configuration

`LogstashRails.config`takes an options hash with the following options:

__transport__

  redis, logstash-udp, logstash-tcp and logfile are available. 
  
  logstash-tcp and logstash-udp should only be used for testing since they produce significant runtime overhead.

__events__

  list of event name patterns to subscribe to. `Regex` and `String` is
  supported. Defaults to `[/.*/]`
  
  See [Active Support Instrumentation](http://edgeguides.rubyonrails.org/active_support_instrumentation.html)
  for the events that `Rails` emmits.
  
__flatten_params__

  `true` or `false`, defaults to true
  
  flatten the params hash of `process_action.action_controller` events. This gets rid of collisions in dynamic mappings in ElasticSearch

__logger__

  logger to use in case of exceptions while pushing events to the transport
  
__transport specific options__

  should be self explaining

redis: 
  * __host__
  * __port__
  * __redis_key__

logfile:
  * __logfile__
  

logstash-tcp:
  * __host__
  * __port__
  

logstash-udp:
  * __host__
  * __port__


### Examples

The most basic configuration looks like:

```ruby
LogstashRails.config(transport: :logfile)
```

This will write _all_ events to `APP_ROOT/log/logstash_rails.log`

A more complete example looks like:

```ruby
if Rails.env.production?
  LogstashRails.config(
    transport: :redis,
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
6. Enjoy a refreshing Orangina and wait

## License

Licensed under the GNU General Public License version 3 (GPLv3). See [LICENSE.txt](/LICENSE.txt) for details.
