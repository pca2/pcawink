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

@client = Wink::Client.new

def get_bulbs()
  @bulbs = {}
  @client.light_bulbs.each do |bulb|
    bulb_name = bulb.name
    @bulbs[bulb_name] = {powered: bulb.powered, brightness: bulb.brightness}
  end
  return @bulbs
end

def set_bulb(bulb_name)
  bulb = @client.light_bulbs.detect {|k| k.name == bulb_name}
end


#br = client.light_bulbs.detect {|k| k.name == 'Bedroom'}



#sunrise(1,0.001,br)


def get_speed(duration:)
  #Returns the what level the dim_level is increased each second
  speed = 1.00 / duration.to_f
  return speed
end

def sunrise(duration:, bulb_name:)
  #How often methodshould pause before
  sleep_rate = 1
  dim_level = 0.001
  speed = get_speed(duration: duration)
  until dim_level >= 1 do
    bulb.dim(dim_level)
    sleep sleep_rate
    puts dim_level
    dim_level += speed
  end
end
