class Owner < ApplicationRecord
  has_many :inventories
  has_many :items, through: :inventories

  has_secure_password

  validates_uniqueness_of :username 
  validates_presence_of :username, :fname, :lname, :company_name, :location, :password_digest

  validates :username, format: {with: /\A^[a-z0-9]*$\z/, message: "-->  Uppercase, Special Characters & Spaces are NOT allowed. Please try again"}
end
