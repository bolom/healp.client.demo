require 'dotenv'
Dotenv.load("#{File.dirname(__FILE__)}/.env")
require_relative "config"


config = Healp::Config.new(ENV['CLIENT_ID'],ENV['CLIENT_SECRET'],ENV['AUTH_URL'])
client = OAuth2::Client.new(config.client_id, config.client_secret, :site =>  config.oauth_url)

access_token = client.password.get_token('jimmy@lobo.studio', "}S'+<01o")

consultation_id = 18

# pickup
p "*try to pickup the consultation #{consultation_id}"
response = RestClient.put "#{config.oauth_url}/consultation_progress/#{consultation_id}.json", {
  access_token: access_token.token,
  content_type: :json
}
p response.code == 200 ? 'success' : 'fail'

sleep(0.01)
#terminated
p "*try to terminal the consultation #{consultation_id}"
response = RestClient.put "#{config.oauth_url}/consultation_terminated/#{consultation_id}.json", {
  access_token: access_token.token,
  content_type: :json
}
p response.code == 200 ? 'success' : 'fail'

