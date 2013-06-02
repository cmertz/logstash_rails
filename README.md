# LogstashRails [![Code Climate](https://codeclimate.com/github/cmertz/logstash-rails.png)](https://codeclimate.com/github/cmertz/logstash-rails) [![Build Status](https://secure.travis-ci.org/cmertz/logstash-rails.png)](http://travis-ci.org/cmertz/logstash-rails) [![Dependency Status](https://gemnasium.com/cmertz/logstash-rails.png)](https://gemnasium.com/cmertz/logstash-rails) [![Coverage Status](https://coveralls.io/repos/cmertz/logstash-rails/badge.png)](https://coveralls.io/r/cmertz/logstash-rails)

Send Logstash events from a Rails application to Redis.


## Usage

Given that you have a logging infrastructure with Logstash and Redis setup, you
have to add an initialzier to your rails app.

A mininal Initializer looks like

    LogstashRails.config(Redis.connect)

This will connect to the redis server on 127.0.0.1:6379 and push all events
that can be handled by LogstashRails to the redis list with key 'logstash'.

If you need to send to a different Redis server, just specify so in
**Redis.connect**.
