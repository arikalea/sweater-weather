require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    # it { should have_many(:road_trips) }
  end

  describe 'instance methods' do
    it 'create_api_key' do
      user = User.create(email: 'example@email.com',
                         password: 'password')
      expect(user.create_api_key).to be_a(String)
    end
  end
end
