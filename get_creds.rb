#!/usr/bin/env ruby
#get credentials
require 'rest_client'
require_relative 'CREDENTIALS.rb'
values   = "{\n    \"client_id\": \"#{CLIENT_ID}\",\n    \"client_secret\": \"#{CLIENT_SECRET}\",\n    \"username\": \"#{USERNAME}\",\n    \"password\": \"#{PASSWORD}\",\n    \"grant_type\": \"password\"\n}"
headers  = {:content_type => "application/json"}
response = RestClient.post "https://winkapi.quirky.com/oauth2/token", values, headers
puts response
