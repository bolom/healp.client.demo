require_relative "base"

class Consultation < Base
  def patient_summaries
    response = RestClient.get "#{config.oauth_url}/consultation_summaries/23.json", {Authorization: "Bearer #{get_access_token}"}
  end
end

rate = Consultation.new
res = rate.patient_summaries
p res.code == 200 ? 'success' : 'fail'
p JSON.parse(res.body)
