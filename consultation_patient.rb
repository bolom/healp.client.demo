require 'dotenv'
Dotenv.load("#{File.dirname(__FILE__)}/.env")
require_relative "config"

config = Healp::Config.new(ENV['CLIENT_ID'],ENV['CLIENT_SECRET'],ENV['AUTH_URL'])
response = RestClient.post "#{config.oauth_url}/oauth/token", {
  grant_type: 'client_credentials',
  client_id: config.client_id,
  client_secret: config.client_secret,
  scope: "admin"
}
p response
token = JSON.parse(response)["access_token"]
consultation_id = 23

token = JSON.parse(response)["access_token"]
response = RestClient.get "#{config.oauth_url}/consultation_summaries/#{consultation_id}.json", {Authorization: "Bearer #{token}"}

p response.code == 200 ? 'success' : 'fail'



