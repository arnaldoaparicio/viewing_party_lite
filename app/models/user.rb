class User < ApplicationRecord
  validates :email, uniqueness: true
  validates_presence_of :password_digest
  has_many :user_parties
  has_many :viewing_parties, through: :user_parties

  has_secure_password
end
