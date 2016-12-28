require 'dotenv'
Dotenv.load

require 'rest-client'
require 'json'
require 'oauth2'

client_id = 'ec3bf3e68ebcffbba61131471e4f94c92887041a0d6c43b297682851fa8ac3df'
client_secret = '6866574e10b5de47f560a470a8a47f73e64e0906d0ee0ffd02895a486bb1dd91'

URL = "https://healp-backend-staging.herokuapp.com"

response = RestClient.post "#{URL}/oauth/token", {
  grant_type: 'client_credentials',
  client_id: client_id,
  client_secret: client_secret,
  scope: "admin"
}

token = JSON.parse(response)["access_token"]

p token

client = OAuth2::Client.new(client_id, client_secret, :site => URL)
access_token = client.password.get_token("patient@lobo.studio", "}S'+<01o")
puts token = access_token.token

patient = {email: 'jimmy0328@gmail.com', password: 'asdfasdf', password_confirmation: 'asdfasdf'}

puts "[Test create Account]"
response = RestClient.post "#{URL}/patients", {:patient=> patient }.to_json, :content_type => 'application/json', :accept => :json

print(response)

puts "[Test Sign in]"
response = RestClient.post "#{URL}/patients/sign_in", {:patient=>{:email => patient[:email], :password => patient[:password]}}.to_json, :content_type => 'application/json', :accept => :json

print(response)

puts "[Test Reset Password]"
response = RestClient.post "#{URL}/patients/password", {:patient=>{:email => patient[:email]}}.to_json, :content_type => 'application/json', :accept => :json

print(response)

def print response
 p response.code
 p response.cookies
 p response.headers
 p JSON.parse(response.body)
end
