/items/ordered_by_name
  all items ordered by their name abc

gather all items
  Items.all

order the items alphabetically
  Items.all.order <-wont work like that >

This works below
  Item.order(:name)

//////