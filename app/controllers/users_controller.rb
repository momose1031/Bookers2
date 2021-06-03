class UsersController < ApplicationController
  # before_action :set_user

  def index
    @users = User.all
    @book = Book.new
    # @relationship = @user.following.find_by(follower_id: current_user.id)
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def followings
    # @followings = @user.following_users
    user = User.find(params[:id])
    @users = user.following_user
  end

  def followers
    # @followers = @user.follower_users
    user = User.find(params[:id])
    @users = user.follower_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  # def set_user
  #   @user = User.find(params[:id])
  # end
end
