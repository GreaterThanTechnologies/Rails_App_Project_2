1. want to get the owner with the most amount of items in their store
2. our join table in the inventories table with items_id owner_id included in the table
#  3. owners, items, and inventories for tables. items only has names. 

scope :scope_idea2, -> {where(Owner.joins(:items), group("items.length").first)}

Owner.
  joins(:items).
  group("items.name").
  