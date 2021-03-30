module InventoriesHelper
  def show_item_name(m, index)
    m.item.name if index
  end


  def form_url_helper(item)
    item ? item_inventories_path(item) : inventories_path
  end
end
