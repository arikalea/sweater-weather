require 'rails_helper'

RSpec.describe 'Geo Service' do
  it 'can retrieve location coords based on location' do
    VCR.use_cassette('dallas') do
      location_results = GeoService.location_data('Dallas')

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
end
