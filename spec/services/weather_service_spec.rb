require 'rails_helper'

RSpec.describe 'Weather Service' do
  it 'can retrieve forecast based on location' do
    VCR.use_cassette('denver_forecast') do
      location_data = MapQuestService.location_data('Denver')
      location = Location.new(location_data)
      forecast_results = WeatherService.get_forecast_by_coords(location.coordinates)

      expect(forecast_results).to be_a(Hash)
      expect(forecast_results).to have_key(:current)
      expect(forecast_results).to have_key(:hourly)
      expect(forecast_results).to have_key(:daily)
    end
  end
end
