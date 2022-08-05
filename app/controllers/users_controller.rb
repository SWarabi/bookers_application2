class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]
  before_action :set_user, only: [:followings, :followers]
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
  end

  def index
    #@user = User.find(params[:id])
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end
  
#   def followings
#     @users = @user.followings
#   end

#   def followers
#     @users = @user.followers
#   end

# private
#   def set_user
#     @user = User.find(params[:id])
#   end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :title)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
