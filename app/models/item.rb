class Item < ApplicationRecord
  has_many :inventories
  has_many :owners, through: :inventories

  accepts_nested_attributes_for :inventories

  validates_presence_of :name, message: " is required"



  
  scope :name_search, ->(name) { self.where("name = ?", name)}

  

end
