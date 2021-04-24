require 'rails_helper'

RSpec.describe 'Forecast request' do
  describe 'It can retrieve weather for a city' do
    it 'has successful response' do
      get '/api/v1/forecast?location=denver,co'

      forecast = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(forecast).to have_key(:lat)
      expect(forecast).to have_key(:lon)
    end
  end
end
