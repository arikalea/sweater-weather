require 'rails_helper'

RSpec.describe 'User registration request' do
  it 'can create a user' do
    user_params = { email: 'example@email.com',
                    password: 'password',
                    password_coonfirmation: 'password'}

    headers = {"CONTENT_TYPE" => "application/json",
               "ACCEPT" => "application/json"}

    post '/api/v1/users', headers: headers, params: user_params.to_json

    new_user = User.last

    expect(response).to be_successful
    expect(response.status).to eq(201)
    expect(response.content_type).to eq("application/json")
  end
end
