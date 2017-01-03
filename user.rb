
require 'dotenv'
Dotenv.load

require 'rest-client'
require 'json'
require 'oauth2'
require_relative "config"

config = Healp::Config.new(ENV['CLIENT_ID'],ENV['CLIENT_SECRET'],ENV['AUTH_URL'])
client = OAuth2::Client.new(config.client_id, config.client_secret, :site =>  config.oauth_url)

response = RestClient.post "#{config.oauth_url}/oauth/token", {
  grant_type: 'client_credentials',
  client_id: config.client_id,
  client_secret: config.client_secret,
  scope: "admin"
}

token = JSON.parse(response)["access_token"]

response = RestClient.get "#{config.oauth_url}/user/search.json", { Authorization: "Bearer #{token}" ,params: {q:'patient@lobo.studio'}}
p response.code
p response.cookies
p response.headers
p JSON.parse(response.body)

