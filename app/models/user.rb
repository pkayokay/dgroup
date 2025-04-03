class User < ApplicationRecord
  has_secure_password
  has_one :plan
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
