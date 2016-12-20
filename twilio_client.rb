require "http"
require 'twilio-ruby'
require 'dotenv'
Dotenv.load("#{File.dirname(__FILE__)}/.env")
require_relative "config"

module Healp
  module Chat
    class Channel

      attr_accessor :client, :service

      def initialize
        @client = Twilio::REST::Client.new(ENV['ACCOUNT_SID'],ENV['AUTH_TOKEN'])
        @service = @client.ip_messaging.v1.services(ENV['IPM_SERVICE_SID']).fetch
      end

      def service
        client.ip_messaging.v1.services(ENV['IPM_SERVICE_SID'])
      end

      def create(name)
        puts "[create channel]"
        channel = service.fetch.channels.create(unique_name: name,
                                                friendly_name: name)
      end

      def channels
        puts "[list channels]"
        channels = service.channels.list()
      end

      def retrieve(channel_id)
        puts "[get channel- #{channel_id}]"
        channel = service.channels(channel_id)
        channel
      end

      def destroy(channel_id)
        puts "[delete channel- #{channel_id}]"
        begin
          channel = retrieve(channel_id)
          response = channel.delete
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

      def notify(identity)
        notify_service_sid = ENV['TWILIO_NOTIFICATION_SERVICE_SID']
        service = client.notify.v1.services(notify_service_sid)
        begin
          notification = service.notifications.create(
            identity: identity,
            body: "Hello",
          );
        rescue Exception => e
          p e.message
        end
      end

    end
  end
end

chat = Healp::Chat::Channel.new
#chat.notify("xxxxx")
#p chat.create("jimmy ip messaging v1")
#puts chat.retrieve("consultation_21").fetch.sid
p chat.destroy('CH09fbac51741b46bcaa1657fbe0897688')
# create message
#(1..5).each do |n|
#  chat.send_message("consultation_21","test_message_#{n}")
#end

#chat_messages = chat.messages("consultation_21")
#puts chat_messages
#
#

