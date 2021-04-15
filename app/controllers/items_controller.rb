class ItemsController < ApplicationController
  before_action(:set_item, except: [:index, :new, :create])
  before_action(:req_login, )
  layout "application"

  def search
    @items = Item.all
    if params[:name]
      @items = Item.name_search(params[:name])
    end
  end

  def order
    @items =  Item.order(:name)
  end


  def show
    @items = Item.all
    @inventories = Inventory.all
   end

  def welcome
  end

  def index
    if !params[:owner_id]
      @items = Item.all
    elsif @owner = Owner.find_by(id: params[:owner_id])
      @items = @owner.items
    else
      redirect_to items_path
    end
  end
  
  def new
    
    @item = Item.new
    @item.inventories.build(owner: current_owner)
    @inventories = @item.inventories.select{|p| p.owner_id == current_owner.id}
    
  end

  def create
    @item = Item.new(item_params)
    @item.inventories.each {|p| p.owner = current_owner}
    if @item.save
      flash[:message] = "Success"
        redirect_to owner_items_path(@item)
    else
      @inventories = @item.inventories.select {|p| p.owner_id == current_owner.id}
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to(item_path(@item))
      flash[:message] = "Successfull"
    else
      @inventories = @item.inventories.select {|p| p.owner_id == current_owner.id}
      render :edit
    end
  end

  def destroy
    @item.delete
    flash[:message] = "Successfully deleted!"
    redirect_to items_path
  end

####
  private

    def item_params
      params.require(:item).permit(:name, inventories_attributes: [:unit, :quantity, :owner_id, :item_id, :id])
    end

    def set_item
      @item = Item.find_by(id: params[:id])
    end

end
