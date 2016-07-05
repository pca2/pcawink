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

CHANGE_FREQ = 7

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



def get_unit(start_level, end_level, time)
  #Initially let's give time in minutes
  #but I guess you could also provide a timestamp and calculate the time
  
  #how often we'll be changing the brightness
  #hard coded as seconds
  #could also be a param at some point
  start_level = start_level.to_f
  end_level = end_level.to_f
  time = time.to_f

  #This is the number of times we'll make a change
  change_count = ((time * 60) / CHANGE_FREQ).to_i
  
  distance = end_level - start_level

  change_unit =  distance / change_count

  return {unit: change_unit, count: change_count}

end



def slowride(bulb, destination, time)
  bulb.reload
  current_level = bulb.brightness
  units = get_unit(current_level,destination, time)

  units[:count].times do
    current_level += units[:unit]
    bulb.dim current_level
    puts "current_level at: #{current_level.to_s}"
    sleep CHANGE_FREQ
  end
  puts "All done!"
end
