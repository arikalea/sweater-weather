require 'rails_helper'

RSpec.describe 'Forecast request' do
  describe 'It can retrieve weather for a city' do
    it 'has successful response' do
      get '/api/v1/forecast?location=denver,co'

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

    end
    # test that I'm getting lat and long
    # test that I'm getting weather for location
  end
end
