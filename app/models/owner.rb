class Owner < ApplicationRecord
  has_many :inventories
  has_many :items, through: :inventories

  has_secure_password

  validates_uniqueness_of :username, message: " is Not Available."
  validates_presence_of :username, :fname, :lname, :company_name, :location, message: " Missing Something. Please Fill Out All Fields"

  validates :username, format: {with: /\A^[a-z0-9]*$\z/, message: "--> Uppercase, Special Characters & Spaces are NOT allowed. Please try again"}
end
