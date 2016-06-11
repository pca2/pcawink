#!/usr/bin/env ruby
#get credentials
require 'rest-client'
require 'json'
require_relative 'CREDENTIALS.rb'
@values = {client_id: CLIENT_ID, client_secret: CLIENT_SECRET, username: USERNAME, password: PASSWORD, grant_type: "password"}
json_values = @values.to_json
headers  = {content_type: "application/json"}
json_response = RestClient.post "https://winkapi.quirky.com/oauth2/token",json_values, headers
@response = JSON.parse(json_response)
puts "access_token: " + @response["access_token"]
puts "refresh_token: " + @response["refresh_token"]
