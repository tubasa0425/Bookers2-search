class BooksController < ApplicationController
	before_action :authenticate_user!
	
# 	追記　投稿とユーザーを紐付けるビフォーアクション↓
	before_action :ensure_correct_user, only: [:edit, :update, :destroy]
	
	

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    # @book_new = Book.new
    # @user = User.find_by_id(current_user.id)
    # @book_comments = @book.book_comments
  end

  def index
    @books = Book.all
    @book = Book.new
    # @user = User.find_by_id(current_user.id)
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    
    if @book.save
      flash[:notice] = "successfully"
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      flash[:notice] = "error"
      @books = Book.all
      render 'index'
    end
  end
  
  

  def edit
    @book = Book.find(params[:id])
    
     if @book.user != current_user
      redirect_to books_path
     end
    
  end



  def update
    # @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end





  def destroy
    # @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  
  # 	追記　投稿とユーザーを紐付ける
  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end

end
