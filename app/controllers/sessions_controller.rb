class SessionsController < ApplicationController

  def new
    @owners = Owner.new 
  end

  def item 
    @items = Item.all
  end

  def items
  end

  def welcome
    # @items = current_owner.items
    # if params[:owner_id]
    #   owner = Owner.find_by(id: params[:owner_id])
    # else
    #   @items = Item.all
    # end
  end

  def create 
    @owner = Owner.find_by(username: params[:owner][:username])
    if @owner && @owner.authenticate(params[:owner][:password])
      session[:owner_id] = @owner.id
      render :welcome
    elsif @owner
      @errors = ["I Believe You Supplied an Invalid Password"]
      render :new
    else
      @errors = ["Maybe an Invalid Username, and/or Potentionally the Password Too! Get it Together!!!"]
      render :new
    end
  end

  def create_with_fb
    owner = Owner.find_or_create_by(username: fb_auth['info']['name'].downcase.delete(' ')) do |p|
      p.password = 'password'
    end
    if owner.save
      session[:owner_id] = owner.id
      render :welcome 
    else
      redirect_to signup_path
    end
  end

  def destroy
    session.clear
    render :welcome
  end

####
  private

  def fb_auth
    self.request.env['omniauth.auth']
  end

 
end

    
