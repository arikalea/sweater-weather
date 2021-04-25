FactoryBot.define do
  factory :user do
    email { 'sample@email.com' }
    password { 'password' }
    api_key { SecureRandom.uuid }
  end
end
