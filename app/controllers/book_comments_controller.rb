class BookCommentsController < ApplicationController
   before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    if @book_comment.save
      flash[:success] = "Comment was successfully created."
    end
    redirect_to request.referer
  end
  
  def destroy
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    redirect_to book_path(params[:book_id])
    
  end
  
private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
  
  
end
