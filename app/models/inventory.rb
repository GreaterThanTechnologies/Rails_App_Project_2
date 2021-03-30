class Inventory < ApplicationRecord
  belongs_to :item
  belongs_to :owner
  validates_presence_of :quantity, :unit

  scope(:quantity_search, ->(quantity) { self.where("quantity >= ?", quantity) })
end
