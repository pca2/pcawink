#!/usr/bin/env ruby
require_relative 'sunrise'
require 'parallel'

hallway = set_bulb "Hallway"
office = set_bulb "Office"
br = set_bulb "Bedroom"
bulbs = [hallway,office,br]

Parallel.each(bulbs, in_threads: bulbs.count) do |bulb|
  slowride(bulb,0.01,30)
end
