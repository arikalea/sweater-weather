require 'rails_helper'

RSpec.describe 'Roadtrip request' do
  describe 'happy path' do
    it 'can retreive roadtrip info' do
      VCR.use_cassette('roadtrip') do
        user = create(:user)

        roadtrip_params = { origin: 'Reno, NV',
                            destination: 'Bozeman, MT',
                            api_key: user.api_key}
        headers = {"CONTENT_TYPE" => "application/json",
                   "ACCEPT" => "application/json"}
        post '/api/v1/road_trip', headers: headers, params: roadtrip_params.to_json

        roadtrip_json = JSON.parse(response.body, symbolize_names: true)
        
        expect(response).to be_successful
        expect(response.status).to eq(201)
        expect(response.content_type).to eq("application/json")
        expect(roadtrip_json).to have_key(:data)
        expect(roadtrip_json[:data].keys).to eq([:id, :type, :attributes])
        expect(roadtrip_json[:data][:attributes].count).to eq(4)
        expect(roadtrip_json[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
        expect(roadtrip_json[:data][:attributes][:weather_at_eta].keys).to eq([:temperature, :conditions])

      end
    end
  end
end
