class Inventory < ApplicationRecord
  belongs_to :item
  belongs_to :owner
  # has_many :items, through: :owners

  validates_presence_of :quantity, :unit, message: " is Missing Something. Please Fill In All Filds"
   
  accepts_nested_attributes_for :item
 
  scope(:quantity_search, ->(quantity) { self.where("quantity >= ?", quantity) })
end
