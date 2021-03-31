class InventoriesController < ApplicationController
  before_action(:req_login)
  layout "application"

  def index
    if params[:quantity]
      @inventories = Inventories.quantity_search(params[:quantity])
    else
      @inventories = Inventory.all
    end
  end

  def new
    if params[:item_id]
      @item = Item.find_by(id: params[:item_id])
      @inventories = @item.inventories.build
      @items = Item.all
    else
      @inventory = Inventory.new
      @inventory.build_item
    end
  end

  def create
    @inventory = Inventory.create(inventories_params)
    @inventory.owner = current_owner
    if params[:item_id]
      @inventory.item_id = params[:item_id]
    end
    if @inventory.save
      redirect_to items_path
    else
      @items = Item.all
      render :new
    end
  end


####
  private

  def inventories_params
    params.require(:inventory).permit(:quantity, :unit, :item_id, :owner_id, item_attributes: [:name])
  end

end