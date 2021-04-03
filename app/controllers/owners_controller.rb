class OwnersController < ApplicationController
  before_action(:req_login, except: [:new, :create])

  def new
    @owner = Owner.new
  end

  def profile 
  end

  def index
  end 
  
  def update
  @owner = current_owner
  @owner.update(owner_params)
    if @current_owner.save
      redirect_to owner_items_path(@owner)
    else
      redirect_to edit_owner_path
    end
  end
   
  def create
    @owner = Owner.new(owner_params)
    if @owner.save
      session[:owner_id] = @owner.id
      flash[:message] = "Successfully created account!"
      redirect_to owner_items_path(@owner)
    else
      @errors = @owner.errors.full_messages
      render :new
    end
  end




  private

  def owner_params
    params.require(:owner).permit(:username, :fname, :lname, :company_name, :password, :location, :password_confirmation)
  end
end
