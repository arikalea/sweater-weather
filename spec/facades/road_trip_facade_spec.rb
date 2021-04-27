require 'rails_helper'

RSpec.describe 'Forecast Facade' do
  it '.get_road_trip' do
    VCR.use_cassette('reno_road_trip') do
      origin = "Denver"
      destination = "Reno"
      facade = RoadTripFacade.get_road_trip(origin, destination)

      expect(facade).to be_a(RoadTrip)
      expect(facade.end_city).to be_a(String)
      expect(facade.end_city).to eq(destination)
      expect(facade.start_city).to be_a(String)
      expect(facade.start_city).to eq(origin)
      expect(facade.travel_time).to be_a(String)
      expect(facade.weather_at_eta).to be_a(Hash)
      expect(facade.weather_at_eta.keys).to eq([:temperature, :conditions])
      expect(facade.weather_at_eta[:temperature]).to be_a(Float)
      expect(facade.weather_at_eta[:conditions]).to be_a(String)
    end
  end
end
