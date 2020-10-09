class SearchController < ApplicationController
def search
@range = params[:range]
search = params[:search]
word = params[:word]
if @range == '1'
@user = User.search(search,word)
else
@book = Book.search(search,word)
# else
# flash[:notice] = "検索結果は0件でした"
# @user = User.none
# @book = Book.none
end
end
end