require 'dotenv'
Dotenv.load

require 'rest-client'
require 'json'
require 'oauth2'


p ENV['CLIENT_ID']
p  ENV['S3_BUCKET']

client_id = 'ec3bf3e68ebcffbba61131471e4f94c92887041a0d6c43b297682851fa8ac3df'
client_secret = '6866574e10b5de47f560a470a8a47f73e64e0906d0ee0ffd02895a486bb1dd91'

URL = "https://healp-backend-staging.herokuapp.com"
#URL ="http://localhost:3001"

response = RestClient.post 'https://healp-backend-staging.herokuapp.com/oauth/token', {
  grant_type: 'client_credentials',
  client_id: client_id,
  client_secret: client_secret,
  scope: "admin"
}

token = JSON.parse(response)["access_token"]

p token

response = RestClient.get 'https://healp-backend-staging.herokuapp.com/user/search.json', { Authorization: "Bearer #{token}" ,params: {q:'bolo@me.com'}}
p response.code
p response.cookies
p response.headers
p   JSON.parse(response.body)


client = OAuth2::Client.new(client_id, client_secret, :site => "https://healp-backend-staging.herokuapp.com")
access_token = client.password.get_token('bolo@lobo.studio', 'azerty')
puts access_token.token

