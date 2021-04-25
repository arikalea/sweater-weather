require 'rails_helper'

RSpec.describe 'User registration request' do
  describe 'happy path' do
    it 'can create a user' do
      user_params = { email: 'example@email.com',
                      password: 'password',
                      password_confirmation: 'password'}

      headers = {"CONTENT_TYPE" => "application/json",
                 "ACCEPT" => "application/json"}

      post '/api/v1/users', headers: headers, params: user_params.to_json

      new_user = User.last
      new_user_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(response.content_type).to eq("application/json")
      expect(new_user_json).to have_key(:data)
      expect(new_user_json[:data].keys).to eq([:id, :type, :attributes])
      expect(new_user_json[:data][:id]).to eq(new_user.id.to_s)
      expect(new_user_json[:data][:attributes].count).to eq(2)
      expect(new_user_json[:data][:attributes].keys).to eq([:email, :api_key])
      expect(new_user_json[:data][:attributes][:email]).to eq(new_user.email)
      expect(new_user_json[:data][:attributes][:api_key]).to eq(new_user.api_key)
    end
  end

  describe 'sad path' do
    it 'does not create user if passwords dont match' do
      user_params = { email: 'example@email.com',
                      password: 'password',
                      password_confirmation: 'password1'}

      headers = {"CONTENT_TYPE" => "application/json",
                 "ACCEPT" => "application/json"}

      post '/api/v1/users', headers: headers, params: user_params.to_json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(User.all.count).to eq(0)
    end
  end
end
