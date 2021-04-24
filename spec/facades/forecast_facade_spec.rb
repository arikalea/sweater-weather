require 'rails_helper'

RSpec.describe 'Forecast Facade' do
  it '.get_location' do
    VCR.use_cassette('stevens_point') do
      location = ForecastFacade.get_location('Stevens Point')

      expect(location).to be_a(Location)
    end
  end

  it '.get_forecast' do
    VCR.use_cassette('dallas') do
      forecast = ForecastFacade.get_forecast('Dallas')
      
      expect(forecast).to be_a(Forecast)
      expect(forecast.location).to be_a(Location)
      expect(forecast.current).to be_a(CurrentForecast)
      expect(forecast.daily.first).to be_a(DailyForecast)
      expect(forecast.hourly.first).to be_a(HourlyForecast)
    end
  end
end
