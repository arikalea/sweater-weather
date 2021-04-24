require 'rails_helper'

RSpec.describe 'Forecast request' do
  describe 'It can retrieve weather for a city' do
    it 'has successful response' do
      VCR.use_cassette('forecast_request') do
        get '/api/v1/forecast?location=denver,co'

        forecast = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(forecast).to have_key(:data)
        expect(forecast[:data].keys).to eq([:id, :type, :attributes])
        expect(forecast[:data][:attributes].keys).to eq([:location, :current, :hourly, :daily])
        expect(forecast[:data][:attributes][:current].keys).to eq([:datetime, :sunrise, :sunset, :temperature, :feels_like, :humidity, :uvi, :visibility, :conditions, :icon])
        expect(forecast[:data][:attributes][:hourly].first.keys).to eq([:time, :temperature, :conditions, :icon])
        expect(forecast[:data][:attributes][:daily].first.keys).to eq([:date, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon])
      end
    end
  end
end
