module ItemsHelper

  

  def form_url_helper(item)
    item ? item_inventories_path(item) : inventories_path
  end
  
end
