class SessionsController < ApplicationController

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
    owner = Owner.find_or_create_by(username: fb_auth['info']['name']) do |fb|
      fb.password = 'password'
    end
    

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

####
  private

  def fb_auth
    self.request.env['omniauth.auth']
  end

end

    
