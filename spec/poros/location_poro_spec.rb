require 'rails_helper'

RSpec.describe 'Location Poro' do
  describe 'happy path' do
    it 'can create poro' do
      attrs = { adminArea5: 'Denver',
                adminArea3: 'CO',
                adminArea1: 'US',
                latlng: { lat: 39.738453, lng: -104.984853}}

      location_poro = Location.new(attrs)

      expect(location_poro).to be_a(Location)
      expect(location_poro.city).to eq(attrs[:adminArea5])
      expect(location_poro.state).to eq(attrs[:adminArea3])
      expect(location_poro.country).to eq(attrs[:adminArea1])
      expect(location_poro.coordinates).to eq(attrs[:latlng])
    end
  end
end
