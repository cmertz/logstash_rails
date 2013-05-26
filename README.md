# LogstashRails [![Code Climate](https://codeclimate.com/github/cmertz/logstash-rails.png)](https://codeclimate.com/github/cmertz/logstash-rails) [![Build Status](https://secure.travis-ci.org/cmertz/logstash-rails.png)](http://travis-ci.org/cmertz/logstash-rails) [![Dependency Status](https://gemnasium.com/cmertz/logstash-rails.png)](https://gemnasium.com/cmertz/logstash-rails)

Send Logstash events from a Rails application to Redis.


## Usage

* add logstash-rails to the applications Gemfile
* provide a __config/logstash-rails.yml__ with the redis connection
  configuration, i.e. __host__ and __port__ and a __key__ for the redis list to
  push to


## TODO

* figure out how to test
* ameliorate basic event
* what happens when exceptions are thrown, e.g. when we do not find an
  apropriate formatter for an event
* introduce environments
* decouple railties initializer from actual formatters
