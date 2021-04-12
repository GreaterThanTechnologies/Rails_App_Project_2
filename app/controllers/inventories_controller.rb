class InventoriesController < ApplicationController
  before_action(:req_login)
  layout "application"

  def index
    if params[:name]
      @inventories = Inventories.name_search(params[:name])
    else
      @inventories = Inventory.all
    end
  end

  def show
    @item = Item.find_by(id: params[:id])
  end

  def new
    
    if params[:item_id]
      
      @item = Item.find_by(id: params[:item_id])
      
      @inventory = @item.inventories.build
      
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

  def edit
    @inventory = Inventory.find_by(id: params[:id])
  end

  def update
    @items = Item.all
    @inventory = current_owner_inventories
    @inventory.update(inventories_params)
    if @inventories.save
      redirect_to owner_iventory_path(@inventories)
    else
      redirect_to edit_inventory_path
    end
  end
  
####
  private

  def current_owner_inventories
    current_owner.inventories
  end

  def inventories_params
    params.require(:inventory).permit(:quantity, :unit, :id, :item_id, :owner_id, item_attributes: [:name])
  end

end