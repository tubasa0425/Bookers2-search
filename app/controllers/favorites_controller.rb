class FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @book = Book.find(params[:book_id])
    
    
    # favorite = current_user.favorites.new(book_id: book.id)
    favorite = @book.favorites.new(user_id: current_user.id) #追記
    

    favorite.save
    
    
    # 元の画面へ遷移するリダイレクト
    redirect_to request.referer #book_path(book)
  
  
  
  end

  def destroy
    # book = Book.find(params[:book_id])
    @book = Book.find(params[:book_id])
  
    # favorite = current_user.favorites.find_by(book_id: book.id)
    favorite = @book.favorites.find_by(user_id: current_user.id)
    
    favorite.destroy
    redirect_to request.referer
  end

end
