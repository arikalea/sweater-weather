require 'rails_helper'

RSpec.describe 'Background request' do
  describe 'It can retrieve image for a city' do
    it 'has a successful response' do
      # VCR.use_cassette('denver_image') do
        get '/api/v1/backgrounds?location=denver,co'

        image = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(200)
      # end
    end
  end
end
