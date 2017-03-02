class User < ActiveRecord::Base
  has_secure_password
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :password, length: 8..20
end
