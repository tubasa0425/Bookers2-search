class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy



  # フォローフォロワー機能の実装　ここから↓


  # フォロー取得↓
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy

  # フォロワー取得↓
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy


  # 自分がフォローしてる人（フォロー）↓
  has_many :following_user, through: :follower, source: :followed

  # 自分をフォローしてる人（フォロワー）↓
  has_many :follower_user, through: :followed, source: :follower


  # def follow(other_user)
  #   unless self == other_user
  #     self.follower.find_or_create_by(followed_id: other_user_id)
  #   end
  # end

  # def unfollow(other_user)
  #   relationship = self.follower.find_by(followed_id: other_user_id)
  #   relationship.destroy if relationship
  # end

  # def following?(other_user)
  #   self.following_user.include?(other_user)
  # end





  # ユーザーをフォローする記述
  def follow(user_id)
    follower.create(followed_id: user_id)
  end


  # ユーザーのフォローを外す記述
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end


  # フォローしていればtrueを返す記述
  def following?(user)
    following_user.include?(user)
  end


  # フォローフォロワー機能実装　ここまで↑



  attachment :profile_image, destroy: false

  validates :name, presence: true, length: {maximum: 20, minimum: 2}, uniqueness: true
  # validates :introduction, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
end
