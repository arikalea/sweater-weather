require 'rails_helper'

RSpec.describe 'Teleport request' do
  describe 'It can retrieve salary and forecast info for a city' do
    it 'has successful response' do
      get '/api/v1/salaries?destination=chicago'

      salaries = JSON.parse(response.body, symbolize_names: true)

      # require "pry";binding.pry
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(salaries).to have_key(:data)
      expect(salaries[:data].keys).to eq([:id, :type, :attributes])
      expect(salaries[:data][:attributes].keys).to eq([:destination, :forecast, :salaries])
    end
  end
end
