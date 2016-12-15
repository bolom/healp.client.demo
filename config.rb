module Healp
  require 'rest-client'
  require 'json'
  require 'oauth2'

  class Config
    def initialize()
      data = YAML::load(File.open("secret.yml"))
      @client_id     =  data["oauth2"]["client_id"]
      @client_secret =  data["oauth2"]["client_secret"]
      @auth_url      =  data["oauth2"]["auth_url"]
    end

    def load
      {
        client_id: @client_id,
        client_secret: @client_secret,
        oauth_url: @auth_url,
      }
    end
  end

end
