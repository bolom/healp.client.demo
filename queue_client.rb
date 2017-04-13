require 'dotenv'
Dotenv.load("#{File.dirname(__FILE__)}/.env")
require_relative "config"

config = Healp::Config.new(ENV['CLIENT_ID'],ENV['CLIENT_SECRET'],ENV['AUTH_URL'])

#config = Healp::Config.new(ENV['CLIENT_ID_STAGING'],ENV['CLIENT_SECRET_STAGING'],ENV['AUTH_URL_STAGING'])

client = OAuth2::Client.new(config.client_id, config.client_secret, :site =>  config.oauth_url)

access_token = client.password.get_token('bolo+patient@lobo.studio', "azerty")

images = []
images << File.new("/Users/Michelin/Desktop/test.png", 'rb')
images << File.new("/Users/Michelin/Desktop/test.png", 'rb')

p access_token.token

response = RestClient.post "#{config.oauth_url}/consultations", {
    access_token: access_token.token,
    profile_id: 115,
    lat: 44.9817,
    long: -93.2783,
    assets: images,
    content_type: :json,
}

p response.code
response_json =  JSON.parse(response.body)
p response_json
p response_json["status"]
p response_json["error"]
