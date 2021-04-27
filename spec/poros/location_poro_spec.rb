require 'rails_helper'

RSpec.describe 'Location Poro' do
  describe 'happy path' do
    it 'can create poro' do
      VCR.use_cassette('stevens_point') do
        location_data = MapQuestService.location_data('Stevens Point')
        location_poro = Location.new(location_data)

        expect(location_poro).to be_a(Location)
        expect(location_poro.city).to eq(location_data[:results][0][:locations][0][:adminArea5])
        expect(location_poro.state).to eq(location_data[:results][0][:locations][0][:adminArea3])
        expect(location_poro.country).to eq(location_data[:results][0][:locations][0][:adminArea1])
        expect(location_poro.coordinates).to eq(location_data[:results][0][:locations][0][:latLng])
      end
    end
  end
end
