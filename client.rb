require 'rest-client'
require 'json'

client_id = 'ce84fa4ea699becba08282996fcde130ad32087827f696711050f6c682ad82bf'
client_secret = 'db9d1d0d7c25ac79ccfee76a8a6985f0f49516abe522f887e521f3bdfd5dbb45'

response = RestClient.post 'https://healp-backend-staging.herokuapp.com/oauth/token', {
  grant_type: 'client_credentials',
  client_id: client_id,
  client_secret: client_secret
}

token = JSON.parse(response)["access_token"]

p token

RestClient.get 'https://healp-backend-staging.herokuapp.com/user/search.json', { Authorization: "Bearer #{token}" ,params: {p:'bolo@me.com'}}
