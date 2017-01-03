require_relative "base"

class Rate < Base
  def consultation_rate
    response = RestClient.post "#{config.oauth_url}/consultation_rate", {
      "access_token" => get_access_token , :rate=>{:consultation_id => 24, rate: 5}}.to_json,
      :content_type => 'application/json', :accept => :json
    print(response)
  end
end

rate = Rate.new
rate.consultation_rate
