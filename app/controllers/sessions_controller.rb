class SessionsController < ApplicationController
  # before_action(:change_fb_name_to_username)

  def new
    @owners = Owner.new 
  end

  def welcome
  end

  def create 
    @owner = Owner.find_by(username: params[:owner][:username])
    if @owner && @owner.authenticate(params[:owner][:password])
      session[:owner_id] = @owner.id
      redirect_to owner_items_path(@owner)
    elsif @owner
      @errors = ["I Believe You Supplied an Invalid Password"]
      render :new
    else
      @errors = ["OK, Maybe an Invalid Username, and/or Potentionally the Password Too"]
      render :new
    end
  end

  def create_with_fb
    owner = Owner.find_or_create_by(username: fb_auth['info']['name'].downcase.delete(' ')) do |fb|
      fb.password = 'password'
      binding.pry
      # owner.change_fb_name_to_username
    end
    # owner.change_fb_name_to_username

    if owner.save
      session[:owner_id] = owner.id
      redirect_to owner_items_path(owner)
    else
      redirect_to signup_path
    end
  end

  def destroy
    session.clear
    redirect_to '/signup'
  end

  # def change_fb_name_to_username
  #   owner = fb_auth['info']['name']
  #   owner = owner.downcase
  #   owner = owner.delete(' ')
  # end

####
  private

  def fb_auth
    self.request.env['omniauth.auth']
  end

 

end

    
