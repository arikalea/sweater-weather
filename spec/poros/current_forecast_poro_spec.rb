require 'rails_helper'

RSpec.describe 'Current forecast poro' do
  describe 'happy path' do
    it 'can create poro' do
      attrs = { current: {
          dt: 1619283098,
          sunrise:  1619266137,
          sunset: 1619315203,
          temp: 79.4,
          feels_like: 39.45,
          humidity: 87,
          uvi: 5.37,
          visibility: 10000,
          weather: [{
            description: 'broken clouds',
            icon: '04d'
          }]
        }
      }

      current_forecast_poro = CurrentForecast.new(attrs)

      expect(current_forecast_poro).to be_a(CurrentForecast)
      expect(current_forecast_poro.datetime).to eq(attrs[:current][:dt])
      expect(current_forecast_poro.sunrise).to eq(attrs[:current][:sunrise])
      expect(current_forecast_poro.sunset).to eq(attrs[:current][:sunset])
      expect(current_forecast_poro.temperature).to eq(attrs[:current][:temp])
      expect(current_forecast_poro.feels_like).to eq(attrs[:current][:feels_like])
      expect(current_forecast_poro.humidity).to eq(attrs[:current][:humidity])
      expect(current_forecast_poro.uvi).to eq(attrs[:current][:uvi])
      expect(current_forecast_poro.visibility).to eq(attrs[:current][:visibility])
      expect(current_forecast_poro.conditions).to eq(attrs[:current][:weather][0][:description])
      expect(current_forecast_poro.icon).to eq(attrs[:current][:weather][0][:icon])
    end
  end
end