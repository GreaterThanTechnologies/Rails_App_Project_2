class Owner < ApplicationRecord
  has_many :inventories
  has_many :items, through: :inventories

  has_secure_password

  validates_uniqueness_of :username, message: " is not available."
  validates_presence_of :username, message: " is required."

  validates :username, format: {with: /\A^[a-z0-9]*$\z/, message: "--> uppercase, special characters & spaces are not permitted."}
end
