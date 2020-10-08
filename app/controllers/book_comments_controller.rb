class BookCommentsController < ApplicationController
   before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    
    # 修正前 @book_comment = current_user.book_comments.new(book_comment_params)
    # 修正後↓
    @book_comment = BookComment.new(book_comment_params)
    @book_comment.book_id = @book.id
    @book_comment. user_id = current_user.id　#追記
    
    
    if @book_comment.save
      flash[:success] = "Comment was successfully created."
      redirect_to request.referer　#追記
      
      # ここから追記
      
      redirect_to request.referer
      
    　else
		  　render 'books/show'
		　end
		　
      # ここまで追記
      
    end
    # redirect_to request.referer
  end
  
  def destroy
    # 修正前　BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    # 修正前　redirect_to book_path(params[:book_id])
    
    # 修正後↓
    @book = Book.find(params[:book_id])
  	book_comment = @book.book_comments.find(params[:id])
		book_comment.destroy
		redirect_to request.referer
    
  end
  
private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
  
  
end
