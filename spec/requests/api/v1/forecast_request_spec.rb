require 'rails_helper'

RSpec.describe 'Forecast request' do
  describe 'happy path' do
    describe 'It can retrieve weather for a city' do
      it 'has successful response' do
        VCR.use_cassette('forecast_request') do
          headers = {"CONTENT_TYPE" => "application/json",
                     "ACCEPT" => "application/json"}

          get '/api/v1/forecast?location=denver,co', headers: headers

          forecast = JSON.parse(response.body, symbolize_names: true)

          expect(response).to be_successful
          expect(response.status).to eq(200)
          expect(forecast).to have_key(:data)
          expect(forecast[:data].keys).to eq([:id, :type, :attributes])
          expect(forecast[:data][:attributes].count).to eq(4)
          expect(forecast[:data][:attributes].keys).to eq([:location, :current, :hourly, :daily])
          expect(forecast[:data][:attributes][:current].keys).to eq([:datetime, :sunrise, :sunset, :temperature, :feels_like, :humidity, :uvi, :visibility, :conditions, :icon])
          expect(forecast[:data][:attributes][:current].keys).to_not eq([:pressure, :dew_point, :clouds])
          expect(forecast[:data][:attributes][:hourly].first.keys).to eq([:time, :temperature, :conditions, :icon])
          expect(forecast[:data][:attributes][:daily].first.keys).to eq([:date, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon])
        end
      end
    end
    describe 'sad path' do
      it 'unsuccessful with empty parameters' do
        headers = {"CONTENT_TYPE" => "application/json",
                   "ACCEPT" => "application/json"}

        get '/api/v1/forecast?location=', headers: headers

        expect(response).to_not be_successful
        expect(response.status).to eq(400)
        
        bad_request_json = JSON.parse(response.body, symbolize_names: true)

        expect(bad_request_json[:error]).to eq('Your parameters are bad')
      end
    end
  end
end
