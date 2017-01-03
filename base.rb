require 'dotenv'
Dotenv.load
require 'rest-client'
require 'json'
require 'oauth2'
require_relative "config"

class Base

  attr_accessor :config, :client
  def initialize
    @config = Healp::Config.new(ENV['CLIENT_ID'],ENV['CLIENT_SECRET'],ENV['AUTH_URL'])
    @client = OAuth2::Client.new(config.client_id, config.client_secret, :site =>  config.oauth_url)
  end

  def get_token
    response = RestClient.post "#{config.oauth_url}/oauth/token", {
      grant_type: 'client_credentials',
      client_id: config.client_id,
      client_secret: config.client_secret,
      scope: "admin"
    }
    token = JSON.parse(response)["access_token"]
    puts token
  end

  def get_access_token
    access_token = client.password.get_token("patient@lobo.studio", "}S'+<01o")
    access_token.token
  end

  def oauth_url
    config.oauth_url
  end

  def print response
   p response.code
   p response.cookies
   p response.headers
   p JSON.parse(response.body)
  end

end
