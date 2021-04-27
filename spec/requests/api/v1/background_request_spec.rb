require 'rails_helper'

RSpec.describe 'Background request' do
  describe 'It can retrieve image for a city' do
    describe 'happy path' do
      it 'has a successful response' do
        VCR.use_cassette('denver_image') do
          get '/api/v1/backgrounds?location=denver,co'

          image = JSON.parse(response.body, symbolize_names: true)

          expect(response).to be_successful
          expect(response.status).to eq(200)
          expect(image).to have_key(:data)
          expect(image[:data].keys).to eq([:id, :type, :attributes])
          expect(image[:data][:id]).to eq('null')
          expect(image[:data][:type]).to eq('image')
          expect(image[:data][:attributes].count).to eq(3)
          expect(image[:data][:attributes].keys).to eq([:location, :url, :credit])
          expect(image[:data][:attributes][:location]).to be_a(String)
          expect(image[:data][:attributes][:url]).to be_a(String)
          expect(image[:data][:attributes][:credit]).to be_a(Hash)
          expect(image[:data][:attributes][:credit].keys).to eq([:source, :photographer])
          expect(image[:data][:attributes][:credit][:source]).to be_a(String)
          expect(image[:data][:attributes][:credit][:photographer]).to be_a(String)
        end
      end
    end
    describe 'sad path' do
      it 'unsuccessful with empty parameters' do
        get '/api/v1/backgrounds?location='

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        bad_request_json = JSON.parse(response.body, symbolize_names: true)
        expect(bad_request_json[:error]).to eq('Your parameters are bad')
      end
    end
  end
end
