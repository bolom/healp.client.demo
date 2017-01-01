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

profile = {name: 'test10', email: 'test13@xxx.xxxx', gender: 0 , birthday_date: '2016-12-11', note: ""}

puts "[Test create Profile]"
response = RestClient.post "#{config.oauth_url}/profiles", {
  access_token: token,
  :profile=> profile }.to_json,
  :content_type => 'application/json', :accept => :json
print(response)
profile = JSON.parse(response.body)

puts "[Edit Profile]"
response = RestClient.put "#{config.oauth_url}/profiles/#{profile['id']}", {
  access_token: token,
  :profile=> {note: 'edit profile'} }.to_json,
  :content_type => 'application/json', :accept => :json
print(response)

puts "[Destroy Profile]"
response = RestClient.delete "#{config.oauth_url}/profiles/#{profile['id']}",{:Authorization => "Bearer #{token}"}

def print response
 p response.code
 p response.cookies
 p response.headers
 p JSON.parse(response.body)
end
