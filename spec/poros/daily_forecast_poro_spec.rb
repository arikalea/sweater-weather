require 'rails_helper'

RSpec.describe 'Daily forecast poro' do
  describe 'happy path' do
    it 'can create poro' do
      attrs = {
          dt: 1619283098,
          sunrise:  1619266137,
          sunset: 1619315203,
          temp: {max: 79.4,
                 min: 38.75},
          weather: [{
            description: 'broken clouds',
            icon: '04d'
          }]
        }

      daily_forecast_poro = DailyForecast.new(attrs)

      expect(daily_forecast_poro).to be_a(DailyForecast)
      expect(daily_forecast_poro.date).to eq(attrs[:dt])
      expect(daily_forecast_poro.sunrise).to eq(attrs[:sunrise])
      expect(daily_forecast_poro.sunset).to eq(attrs[:sunset])
      expect(daily_forecast_poro.max_temp).to eq(attrs[:temp][:max])
      expect(daily_forecast_poro.min_temp).to eq(attrs[:temp][:min])
      expect(daily_forecast_poro.conditions).to eq(attrs[:weather][0][:description])
      expect(daily_forecast_poro.icon).to eq(attrs[:weather][0][:icon])
    end
  end
end
