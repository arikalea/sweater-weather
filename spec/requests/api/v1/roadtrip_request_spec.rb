require 'rails_helper'

RSpec.describe 'Roadtrip request' do
  describe 'happy path' do
    before :each do
      @user = create(:user)
    end

    it 'can retrieve roadtrip info' do
      VCR.use_cassette('roadtrip') do
        roadtrip_params = { origin: 'Reno, NV',
                            destination: 'Bozeman, MT',
                            api_key: @user.api_key}
        headers = {"CONTENT_TYPE" => "application/json",
                   "ACCEPT" => "application/json"}
        post '/api/v1/road_trip', headers: headers, params: roadtrip_params.to_json

        roadtrip_json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(response.content_type).to eq("application/json")
        expect(roadtrip_json).to have_key(:data)
        expect(roadtrip_json[:data].keys).to eq([:id, :type, :attributes])
        expect(roadtrip_json[:data][:attributes].count).to eq(4)
        expect(roadtrip_json[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
        expect(roadtrip_json[:data][:attributes][:weather_at_eta].keys).to eq([:temperature, :conditions])
      end
    end
    it 'can retrieve very long roadtrip info' do
      VCR.use_cassette('long_roadtrip') do
        roadtrip_params = { origin: 'San Diego, CA',
                            destination: 'Portland, ME',
                            api_key: @user.api_key}
        headers = {"CONTENT_TYPE" => "application/json",
                   "ACCEPT" => "application/json"}
        post '/api/v1/road_trip', headers: headers, params: roadtrip_params.to_json

        roadtrip_json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(response.content_type).to eq("application/json")
        expect(roadtrip_json).to have_key(:data)
        expect(roadtrip_json[:data].keys).to eq([:id, :type, :attributes])
        expect(roadtrip_json[:data][:attributes].count).to eq(4)
        expect(roadtrip_json[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
        expect(roadtrip_json[:data][:attributes][:weather_at_eta].keys).to eq([:temperature, :conditions])
      end
    end
  end
  describe 'sad path' do
    before :each do
      @user = create(:user)
    end

    it 'unsuccessful request without api key' do
      roadtrip_params = { origin: 'San Diego, CA',
                          destination: 'Portland, ME'}

      headers = {"CONTENT_TYPE" => "application/json",
                 "ACCEPT" => "application/json"}
      post '/api/v1/road_trip', headers: headers, params: roadtrip_params.to_json

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      expect(response.content_type).to eq("application/json")

      bad_request_json = JSON.parse(response.body, symbolize_names: true)

      expect(bad_request_json[:error]).to eq("Must provide valid API key")
    end

    it 'unsuccessful request with invalid api key' do
      roadtrip_params = { origin: 'San Diego, CA',
                          destination: 'Portland, ME',
                          api_key: 123456}

      headers = {"CONTENT_TYPE" => "application/json",
                 "ACCEPT" => "application/json"}
      post '/api/v1/road_trip', headers: headers, params: roadtrip_params.to_json

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      expect(response.content_type).to eq("application/json")

      bad_request_json = JSON.parse(response.body, symbolize_names: true)

      expect(bad_request_json[:error]).to eq("Must provide valid API key")
    end

    it 'unsuccessful request without request body' do
      roadtrip_params = { api_key: @user.api_key }

      headers = {"CONTENT_TYPE" => "application/json",
                 "ACCEPT" => "application/json"}
      post '/api/v1/road_trip', headers: headers, params: roadtrip_params.to_json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(response.content_type).to eq("application/json")

      bad_request_json = JSON.parse(response.body, symbolize_names: true)

      expect(bad_request_json[:error]).to eq('Must provide request body')
    end

    it 'unsuccessful request without origin' do
      roadtrip_params = { destination: 'Portland, ME',
                          api_key: @user.api_key }

      headers = {"CONTENT_TYPE" => "application/json",
                 "ACCEPT" => "application/json"}
      post '/api/v1/road_trip', headers: headers, params: roadtrip_params.to_json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(response.content_type).to eq("application/json")

      bad_request_json = JSON.parse(response.body, symbolize_names: true)

      expect(bad_request_json[:error]).to eq('Must provide request body')
    end

    it 'unsuccessful request without destination' do
      roadtrip_params = { origin: 'San Diego, CA',
                          api_key: @user.api_key }

      headers = {"CONTENT_TYPE" => "application/json",
                 "ACCEPT" => "application/json"}
      post '/api/v1/road_trip', headers: headers, params: roadtrip_params.to_json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(response.content_type).to eq("application/json")

      bad_request_json = JSON.parse(response.body, symbolize_names: true)

      expect(bad_request_json[:error]).to eq('Must provide request body')
    end

    it 'unsuccessful request for impossible trip' do
      VCR.use_cassette('oversea_roadtrip') do
        roadtrip_params = { origin: 'San Diego, CA',
                            destination: 'Havana, Cuba',
                            api_key: @user.api_key }

        headers = {"CONTENT_TYPE" => "application/json",
                   "ACCEPT" => "application/json"}
        post '/api/v1/road_trip', headers: headers, params: roadtrip_params.to_json

        post '/api/v1/road_trip', headers: headers, params: roadtrip_params.to_json

        roadtrip_json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(response.content_type).to eq("application/json")
        expect(roadtrip_json).to have_key(:data)
        expect(roadtrip_json[:data].keys).to eq([:id, :type, :attributes])
        expect(roadtrip_json[:data][:attributes].count).to eq(4)
        expect(roadtrip_json[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
        expect(roadtrip_json[:data][:attributes][:travel_time]).to eq('This route is impossible.')
        expect(roadtrip_json[:data][:attributes][:weather_at_eta]).to eq({})
      end
    end
  end
end
