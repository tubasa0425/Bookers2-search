class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find_by_id(params[:id])
    @books = Book.all
    @book = Book.new
    @user = User.find(params[:id])
    @user = User.find_by_id(current_user.id)
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    
    if @user.save
      flash[:notice] = "successfully"
    else
      flash[:notice] = "error"
      render "edit"
      @user = current_user
    end
    
    
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
