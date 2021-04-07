class SessionsController < ApplicationController

  def new
    @errors = []
    @owners = Owner.new 
  end

  def item 
  end

  def items
    @items = Item.all
  end

  def welcome
  end

  def create 
    @owner = Owner.find_by(username: params[:owner][:username])
    if @owner && @owner.authenticate(params[:owner][:password])
      session[:owner_id] = @owner.id
      render :welcome
    elsif @owner
      @errors = ["Invalid password."]
      render :new
    else
      @errors = ["Invalid username and/or password."]
      render :new
    end
  end

  def create_with_fb
    owner = Owner.find_or_create_by(username: fb_auth['info']['name'].downcase.delete(' ')) do |p|
      p.password = 'password'
    end
    if owner.save
      session[:owner_id] = owner.id
      flash[:message] = "Successfully logged in!"
      render :welcome 
    else
      flash[:message] = "Login failed!"
      redirect_to signup_path
    end
  end

  def destroy
    session.clear
    flash[:message] = "Successfully logged out!"
    render :welcome
  end

####
  private

  def fb_auth
    self.request.env['omniauth.auth']
  end

 
end

    
