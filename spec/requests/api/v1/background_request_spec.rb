require 'rails_helper'

RSpec.describe 'Background request' do
  describe 'It can retrieve image for a city' do
    it 'has a successful response' do
      VCR.use_cassette('denver_image') do
        get '/api/v1/backgrounds?location=denver,co'

        image = JSON.parse(response.body, symbolize_names: true)
        # require "pry";binding.pry
        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(image.keys).to eq([:id, :location, :url, :credit])
        expect(image[:credit].keys).to eq([:source, :photographer])
      end
    end
  end
end
