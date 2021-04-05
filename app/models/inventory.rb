class Inventory < ApplicationRecord
  belongs_to :item
  belongs_to :owner

  validates_presence_of :quantity, :unit, message: " is Missing Something. Please Fill In All Fields"
   
  accepts_nested_attributes_for :item



 
end
