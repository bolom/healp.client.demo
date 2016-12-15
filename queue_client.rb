$LOAD_PATH << '.'
require "config"

config = Healp::Config.new.load

response = RestClient.post "#{config[:oauth_url]}/oauth/token", {
  grant_type: 'client_credentials',
  client_id: config[:client_id],
  client_secret: config[:client_secret],
  scope: "admin"
}
token = JSON.parse(response)["access_token"]

p token

response = RestClient.post "#{config[:oauth_url]}/queues", {
  access_token: token,
}
p response.code
