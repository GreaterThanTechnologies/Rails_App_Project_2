class Inventory < ApplicationRecord
  belongs_to :item
  belongs_to :owner

  validates_presence_of :quantity, :unit, message: " is missing something, please fill in all fields."
   
  accepts_nested_attributes_for :item



 
end
