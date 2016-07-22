#!/usr/bin/env ruby
puts "testing"
require_relative 'sunrise'
require 'parallel'


hallway = set_bulb "Hallway"
office = set_bulb "Office"
br = set_bulb "Bedroom"
bulbs = [hallway,br]

puts "Running!"

Parallel.each(bulbs, in_threads: bulbs.count) do |bulb|
  slowride(bulb,1,2)
end
