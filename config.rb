module Healp
  require 'rest-client'
  require 'json'
  require 'oauth2'

  class Config

     attr_accessor :client_id, :client_secret, :oauth_url

    def initialize(client_id,client_secret,oauth_url)
      @client_id     =  client_id
      @client_secret =  client_secret
      @oauth_url      =  oauth_url
    end
  end

end
