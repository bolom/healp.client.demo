require 'dotenv'
require 'stripe'

Dotenv.load("#{File.dirname(__FILE__)}/.env")
require_relative "config"

Stripe.api_key = ENV['STRIPE_SECRET_KEY']

config = Healp::Config.new(ENV['CLIENT_ID'],ENV['CLIENT_SECRET'],ENV['AUTH_URL'])

client = OAuth2::Client.new(config.client_id, config.client_secret, :site =>  config.oauth_url)

access_token = client.password.get_token('patient@lobo.studio', "}S'+<01o")

puts access_token.token

card = Stripe::Token.create(
  :card => {
  :number => "4242424242424242",
  :exp_month => 12,
  :exp_year => 2017,
  :cvc => "314"
 }
)

stripe_token = card.id
puts "card id: #{stripe_token}"
response = RestClient.post "#{config.oauth_url}/patient/subscriptions", {"access_token" => access_token.token,"stripe_token" => stripe_token, "coupon"=> 'coupon1111'
}, {:content_type => 'application/json', :accept => :json}

p JSON.parse(response.body)
