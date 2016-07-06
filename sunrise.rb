#!/usr/bin/env ruby
require 'bundler/setup'
require 'wink'
require './CREDENTIALS.rb'

Wink.configure do |wink|
  wink.client_id     = CLIENT_ID
  wink.client_secret = CLIENT_SECRET
  wink.access_token  = ACCESS_TOKEN
  wink.refresh_token = REFRESH_TOKEN
end

@client = Wink::Client.new

#The number of seconds we'll sleep between brightness adjustments
SLEEP_INTERVAL = 7

def get_bulbs()
  #Return info on all known bulbs 
  @bulbs = {}
  @client.light_bulbs.each do |bulb|
    bulb_name = bulb.name
    @bulbs[bulb_name] = {powered: bulb.powered, brightness: bulb.brightness}
  end
  return @bulbs
end

def set_bulb(bulb_name)
  #define a bulb object to a specific var
  bulb = @client.light_bulbs.detect {|k| k.name == bulb_name}
end



def get_unit(start_level, end_level, time)
  #Calulate the increment of change each time
  #and the number of changes that will be made

  #level range is 0.01 to 1.
  start_level = start_level.to_f
  end_level = end_level.to_f
  #Time is in minutes
  #TODO: add ability to accept time as timestamp and calculate time until then
  time = time.to_f
  
  #The number of changes to the brightness we'll make
  change_count = ((time * 60) / SLEEP_INTERVAL).to_i
  
  distance = end_level - start_level

  #The amount we'll change each time
  change_increment =  distance / change_count

  return {inc: change_increment, count: change_count}
end



def slowride(bulb, destination, time)
  #run the actual dimming


  bulb.reload
  current_level = bulb.brightness
  units = get_unit(current_level,destination, time)

  units[:count].times do
    current_level += units[:inc]
    bulb.dim current_level
    puts "current_level of #{bulb.name} at: #{current_level.to_s}"
    sleep SLEEP_INTERVAL
  end

end
