require 'dotenv'
Dotenv.load

require 'rest-client'
require 'json'
require 'oauth2'
require_relative "config"

config = Healp::Config.new(ENV['CLIENT_ID'],ENV['CLIENT_SECRET'],ENV['AUTH_URL'])
client = OAuth2::Client.new(config.client_id, config.client_secret, :site =>  config.oauth_url)

access_token = client.password.get_token("patient@lobo.studio", "}S'+<01o")
puts token = access_token.token

puts "[create rate]"
response = RestClient.post "#{config.oauth_url}/consultation_rate", {"access_token" => token , :rate=>{:consultation_id => 24, rate: 5}}.to_json, :content_type => 'application/json', :accept => :json
print(response)


def print response
 p response.code
 p response.cookies
 p response.headers
 p JSON.parse(response.body)
end
