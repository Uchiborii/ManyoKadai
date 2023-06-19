class User < ApplicationRecord
  validates :name, length: { maximum: 50 }, presence: true
  validates :email, length: { maximum: 50 }, uniqueness: true
  validates :password, length: { minimum: 6 }, presence: true
  before_validation { email.downcase! }
  has_secure_password
  has_many :tasks
end
