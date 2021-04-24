require 'rails_helper'

RSpec.describe 'Forecast request' do
  describe 'It can retrieve weather for a city' do
    it 'has successful response' do
      VCR.use_cassette('forecast_request') do
        get '/api/v1/forecast?location=denver,co'

        forecast = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(forecast.keys).to eq([:id, :location, :current, :hourly, :daily])
        expect(forecast[:current].keys).to eq([:datetime, :sunrise, :sunset, :temperature, :feels_like, :humidity, :uvi, :visibility, :conditions, :icon])
        expect(forecast[:hourly].first.keys).to eq([:time, :temperature, :conditions, :icon])
        expect(forecast[:daily].first.keys).to eq([:date, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon])
      end
    end
  end
end
