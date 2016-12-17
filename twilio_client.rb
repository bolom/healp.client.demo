require "http"
require 'twilio-ruby'
require 'dotenv'
Dotenv.load("#{File.dirname(__FILE__)}/.env")
require_relative "config"

module Healp
  module Chat
    class Channel

      attr_accessor :ip_messaging_client, :service

      def initialize
        @ip_messaging_client = Twilio::REST::IpMessagingClient.new(ENV['ACCOUNT_SID'],ENV['AUTH_TOKEN'])
        @service = @ip_messaging_client.services.get(ENV['IPM_SERVICE_SID'])
      end

      def create(name)
        puts "[create channel]"
        channel = service.channels.create(unique_name: name,
                                          friendlyName: name,
                                          created_by: 'jimmy0328@gmail.com')
      end

      def service
        ip_messaging_client.services.get(ENV['IPM_SERVICE_SID'])
      end

      def channels
        puts "[list channels]"
        channels = service.channels.list()
      end

      def retrieve(channel_id)
        puts "[get channel- #{channel_id}]"
        channel = service.channels.get(channel_id)
        channel
      end

      def destroy(channel_id)
        puts "[delete channel- #{channel_id}]"
        begin
          channel = retrieve(channel_id)
          response = channel.delete()
        rescue Exception => e
          p e.message
        end
        response
      end

      def messages(channel_id)
        channel = retrieve(channel_id)
        messages = channel.messages.list()
      end

      def send_message(channel_id, msg)
        channel = retrieve(channel_id)
        response = channel.messages.create(body: msg)
      end
    end
  end
end

#chat = Healp::Chat::Channel.new
#p chat.create("jimmy_test_create_channel")
#p chat.retrieve("jimmy_test_create_channel")
#p chat.destroy('CH80af98bf991140a8bf03908d8cceeca7')
# create message
#(1..5).each do |n|
#  chat.send_message("CH1f60928a62e745ae8fbe32f4a9b4751c","test_message_#{n}")
#end
#chat_messages = chat.messages("CH1f60928a62e745ae8fbe32f4a9b4751c")
#
#

