require 'rails_helper'

RSpec.describe 'User login request' do
  describe 'happy path' do
    before :each do
      user_params = { email: 'example@email.com',
                      password: 'password',
                      password_confirmation: 'password'}

      headers = {"CONTENT_TYPE" => "application/json",
                 "ACCEPT" => "application/json"}

      post '/api/v1/users', headers: headers, params: user_params.to_json
    end
    
    it 'can login a user' do
      user_params = { email: 'example@email.com',
                      password: 'password' }

      headers = {"CONTENT_TYPE" => "application/json",
                 "ACCEPT" => "application/json"}

      post '/api/v1/sessions', headers: headers, params: user_params.to_json

      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
  end
end
