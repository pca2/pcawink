#!/usr/bin/env ruby
require 'bundler/setup'
require 'wink'
require './MY_CREDENTIALS.rb'

Wink.configure do |wink|
  wink.client_id     = CLIENT_ID
  wink.client_secret = CLIENT_SECRET
  wink.access_token  = ACCESS_TOKEN
  wink.refresh_token = REFRESH_TOKEN
end

client = Wink::Client.new
br = client.light_bulbs.detect {|k| k.name == 'Bedroom'}

def sunrise(sleep_rate,increment, bulb)
  level = 0.001
  until level >= 1 do
    bulb.dim(level)
    sleep sleep_rate
    puts level
    level += increment
  end
end


sunrise(1,0.001,br)


