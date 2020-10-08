class RelationshipsController < ApplicationController
  
  # フォローフォロワー機能の実装ここから
  
  def follow
    current_user.follow(params[:id])
    redirect_to request.referer
  end

  def unfollow
    current_user.unfollow(params[:id])
    redirect_to request.referer
  end

  
  # フォローフォロワー機能の実装ここまで
  
end
