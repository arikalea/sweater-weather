require 'rails_helper'

RSpec.describe 'Forecast request' do
  describe 'It can retrieve weather for a city' do
    before :each do
      get '/api/v1/forecast?location=denver,co'
    end
  end
end
