require 'rails_helper'

RSpec.describe 'Background request' do
  describe 'It can retrieve image for a city' do
    it 'has a successful response' do
      VCR.use_cassette('denver_image') do
        get '/api/v1/backgrounds?location=denver,co'

        image = JSON.parse(response.body, symbolize_names: true)
        
        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(image).to have_key(:data)
        expect(image[:data].keys).to eq([:id, :type, :attributes])
        expect(image[:data][:attributes].count).to eq(3)
        expect(image[:data][:attributes].keys).to eq([:location, :url, :credit])
        expect(image[:data][:attributes][:credit].keys).to eq([:source, :photographer])
      end
    end
  end
end
