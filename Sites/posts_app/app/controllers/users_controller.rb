class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def new
  	@user = User.new
    @title = "Sign up"
  end

  def create
  	#raise params[:user].inspect
  	@user = User.new(params[:user])
  	if @user.save
  		#flash[:success] = "Welcome to the Sample App!"
  		#redirect_to @user
      sign_in @user
      redirect_to @user, :flash => { :success => "Welcome to the sample App!" }
  	else
  		@title = "Sign up"
  		render "new"  	end
  end

  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
  end

end
