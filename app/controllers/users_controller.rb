class UsersController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def show
    @book= Book.new
    @user= User.find(params[:id])
    @books= Book.all
  end

  def index
    @book = Book.new
    @user= current_user
    @users= User.all
  end

  def edit
    @user= User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated book successfully."
    redirect_to user_path(@user)
    else
    flash[:notice] = "error"
    render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
