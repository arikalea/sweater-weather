require 'rails_helper'

RSpec.describe 'Map Quest Service' do
  it 'can retrieve location coords based on location' do
    VCR.use_cassette('dallas') do
      location_results = MapQuestService.location_data('Dallas')

      expect(location_results).to be_a(Hash)
      expect(location_results).to have_key(:results)
      expect(location_results[:results]).to be_a(Array)
      expect(location_results[:results].first).to have_key(:locations)
      expect(location_results[:results].first[:locations]).to be_an(Array)
      expect(location_results[:results].first[:locations].first).to have_key(:adminArea5)
      expect(location_results[:results].first[:locations].first).to have_key(:adminArea3)
      expect(location_results[:results].first[:locations].first).to have_key(:adminArea1)
      expect(location_results[:results].first[:locations].first).to have_key(:latLng)
    end
  end

  it 'can retrieve road trip data based on origin and destination' do
    VCR.use_cassette('roadtrip') do
      road_trip_results = MapQuestService.road_trip_data('Reno, NV', 'Bozeman, MT')
      
      expect(road_trip_results).to be_a(Hash)
      expect(road_trip_results).to have_key(:route)
      expect(road_trip_results[:route]).to be_a(Hash)
      expect(road_trip_results).to have_key(:info)
      expect(road_trip_results[:info]).to be_a(Hash)
    end
  end
end
