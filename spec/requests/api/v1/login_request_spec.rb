require 'rails_helper'

RSpec.describe 'User login request' do
  describe 'happy path' do
    it 'can login a user' do
      user = create(:user)
      login_params = { email: user.email,
                       password: user.password }

      headers = {"CONTENT_TYPE" => "application/json",
                 "ACCEPT" => "application/json"}

      post '/api/v1/sessions', headers: headers, params: login_params.to_json

      login_json = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.content_type).to eq("application/json")
      expect(login_json).to have_key(:data)
      expect(login_json[:data].keys).to eq([:id, :type, :attributes])
      expect(login_json[:data][:attributes].count).to eq(2)
      expect(login_json[:data][:type]).to eq('user')
      expect(login_json[:data][:attributes][:email]).to eq(user.email)
      expect(login_json[:data][:attributes][:api_key]).to eq(user.api_key)
    end
  end
end
