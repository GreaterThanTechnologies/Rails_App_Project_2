class ApplicationController < ActionController::Base
  helper_method(:current_owner)

  def current_owner
    @current_owner = Owner.find_by(id: session[:owner_id])
  end

  def req_login
    redirect_to '/login' if !current_owner
  end

end
end
