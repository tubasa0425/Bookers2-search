class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    # @user = User.find_by_id(params[:id])
    # @books = Book.all
    # @book = Book.new
    # @user = User.find(params[:id])
    # @user = User.find_by_id(current_user.id)

    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new

  end

  def index
    # @user = User.find(params[:id])
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



  def following
      @user  = User.find(params[:id])
      @users = @user.follower
      render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followed
    render 'show_follower'
  end

  # def search
  #   if params[:name].present?
  #     @users = User.where('name LIKE ?', "%#{params[:name]}%")
      
  #     @books = Book.where('title LIKE ?', "%#{params[:title]}%")
      
  #   else
  #     flash[:notice] = "検索結果は0件でした"
  #     @users = User.none
      
  #     @books = Book.none
  #   end
  # end
  

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
