module ApplicationHelper
  def display_error
    @errors = @item.errors.full_messages
  end

  # def search_all_items
  #   @items = Item.all
  #   if params[:name]
  #     @items = Item.name_search(params[:name])
  #   end

  # end
end
