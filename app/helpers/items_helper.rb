module ItemsHelper

  def show_item(m, index)
    m.item.name if index
  end

  def form_url_helper(item)
    item ? item_inventories_path(item) : inventories_path
  end
  
end
