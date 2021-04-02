module ApplicationHelper
  def display_error
    @errors = @item.errors.full_messages
  end
end
