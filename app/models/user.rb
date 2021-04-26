class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :password, presence: { require: true }
  has_secure_password

  def create_api_key
    self.api_key = SecureRandom.uuid
  end
end
