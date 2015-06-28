class UsersController < ApplicationController
before_action :authenticate_user!, only: [:index, :edit, :update]
before_action :admin_user,     only: :destroy
before_filter :authenticate_user!, :except=>[:show]

  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end
  
  private
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
