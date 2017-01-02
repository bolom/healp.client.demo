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
p token

# patient login
access_token = client.password.get_token("patient@lobo.studio", "}S'+<01o")
puts token = access_token.token

# fake data
patient = {email: 'jimmy032801@gmail.com', password: 'asdfasdf', password_confirmation: 'asdfasdf'}

puts "[Test create Account]"
response = RestClient.post "#{config.oauth_url}/patients", {:patient=> patient }.to_json, :content_type => 'application/json', :accept => :json
print(response)

puts "[Test Sign in]"
response = RestClient.post "#{config.oauth_url}/patients/sign_in", {:patient=>{:email => patient[:email], :password => patient[:password]}}.to_json, :content_type => 'application/json', :accept => :json
print(response)

puts "[Test Reset Password]"
response = RestClient.post "#{config.oauth_url}/patients/password", {:patient=>{:email => patient[:email]}}.to_json, :content_type => 'application/json', :accept => :json
print(response)

def print response
 puts response.code
 puts response.cookies
 puts response.headers
 puts JSON.parse(response.body)
end
