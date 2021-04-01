class ItemsController < ApplicationController
  before_action(:set_item, except: [:index, :new, :create])
  before_action(:req_login)

  layout "application"

  def index
    if params[:owner_id]
      owner = Owner.find_by(id: params[:owner_id])
      @items = owner.items
     else
      @items = Item.all
    end
  end

  def show
  end

  def welcome
  end
  
  def new
    @item = Item.new
    @item.inventories.build(owner: current_owner)
    @inventories = @item.inventories.select{|p| p.owner_id == current_owner.id}
  end

  def create
    @item = Item.new(item_params)
    @item.inventories.each do |p|
      p.owner = current_owner
    end
    if @item.save
        redirect_to item_path(@item)
    else
      @errors = @item.errors.full_messages
      @inventories = @item.inventories.select{|p| p.owner_id == current_owner.id}
      render :new
    end
  end

  def edit
    
    @inventories = @item.inventories.where(owner_id: current_owner.id)
    @item = Item.all
  end

  def update
    if @item.update(item_params)
      redirect_to(item_path(@item))
    else
      @inventories = @item.inventories.select do |p|
        p.owner_id == current_owner.id
      end
      @errors = @item.errors.full_messages
      @inventories = @item.inventories.select{|p| p.owner_id == current_owner.id}
      render :edit
    end
  end


  def destroy
    @item.delete
    redirect_to items_path
  end

####
  private

    def item_params
      params.require(:item).permit(:name, inventories_attributes: [:unit, :quantity, :owner_id, :item_id])
    end

    def set_item
      @item = Item.find_by(id: params[:id], name: params[:name])
    end


end
