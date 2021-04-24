require 'rails_helper'

RSpec.describe 'Hourly forecast poro' do
  describe 'happy path' do
    it 'can create poro' do
      attrs = {
          dt: 1619283098,
          temp: 79.4,
          weather: [{
            description: 'broken clouds',
            icon: '04d'
          }]
        }

      hourly_forecast_poro = HourlyForecast.new(attrs)

      expect(hourly_forecast_poro).to be_a(HourlyForecast)
      expect(hourly_forecast_poro.time).to eq(attrs[:dt])
      expect(hourly_forecast_poro.temperature).to eq(attrs[:temp])
      expect(hourly_forecast_poro.conditions).to eq(attrs[:weather][0][:description])
      expect(hourly_forecast_poro.icon).to eq(attrs[:weather][0][:icon])
    end
  end
end
