require 'spec_helper'

describe 'LogstashRails.config' do

  def redis
    Redis.new
  end

  it 'raises an ArgumentError if the handle_all flag is not a boolean' do
    lambda do
      LogstashRails.config(redis, 'fookey', 'somerandomstring')
    end.must_raise(ArgumentError)
  end

  it 'raises an ArgumentError if the key is not a string' do
    lambda do
      LogstashRails.config(redis, 123, true)
    end.must_raise(ArgumentError)
  end

  it 'raises an ArgumentError if redis is nil' do
    lambda do
      LogstashRails.config(nil, 'fookey', true)
    end.must_raise(ArgumentError)
  end

end
