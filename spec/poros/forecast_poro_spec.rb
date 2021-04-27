require 'rails_helper'

RSpec.describe 'Forecast poro' do
  describe 'happy path' do
    it 'can create poro' do
      VCR.use_cassette('denver_forecast') do
        location_data = MapQuestService.location_data('Denver')
        location = Location.new(location_data)

        forecast_data = WeatherService.get_forecast_by_coords(location.coordinates)

        forecast = Forecast.new(location, forecast_data)

        expect(forecast).to be_a(Forecast)
        expect(forecast.id).to be_nil
        expect(forecast.location).to be_a(Location)
        expect(forecast.current).to be_a(CurrentForecast)
        expect(forecast.hourly.first).to be_a(HourlyForecast)
        expect(forecast.hourly.count).to eq(8)
        expect(forecast.daily.first).to be_a(DailyForecast)
        expect(forecast.daily.count).to eq(5)
      end
    end
  end
end
