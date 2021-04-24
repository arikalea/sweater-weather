require 'rails_helper'

RSpec.describe 'Forecast request' do
  describe 'It can retrieve weather for a city' do
    it 'has successful response' do
      get '/api/v1/forecast?location=denver,co'

      forecast = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(forecast[:data].count).to eq(3)
      expect(forecast[:data].keys).to eq([:id], [:type], [:attributes])
      expect(forecast[:data][:id]).to be_nil
      expect(forecast[:data][:type]).to eq('forecast')
      expect(forecast[:data][:attributes].keys).to eq([:current_weather, :daily_weather, :hourly_weather])
      expect(forecast[:data][:attributes][:current_weather].keys).to eq([:datetime, :sunrise, :sunset, :temperature, :feels_like, :humidity, :uvi, :visibility, :conditions, :icon])
      expect(response[:data][:attributes][:daily_weather].first.keys).to eq([:datetime, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon])
      expect(response[:data][:attributes][:hourly_weather].first.keys).to eq([:time, :temperature, :conditions, :icon]))

    end
  end
end
