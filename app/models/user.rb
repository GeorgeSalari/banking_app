class User < ApplicationRecord
  has_secure_password

  validates :password, :password_confirmation, :email, presence: true
  validates :email, uniqueness: true
end
