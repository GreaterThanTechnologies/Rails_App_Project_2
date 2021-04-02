class ApplicationController < ActionController::Base
  helper_method(:current_owner)

  def current_owner
    @current_owner = Owner.find_by(id: session[:owner_id])
  end

  def req_login
    redirect_to '/' if !current_owner
  end

  def current_owner_inventory
    @current_owner = Owner.find_by(id: session[:owner_id])
    @cureent_owner.inventories
  end

 
end
 
