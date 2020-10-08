class BookComment < ApplicationRecord
  
  belongs_to :user
  belongs_to :book
  
  # 追記
  validates :comment, presence: true
  
end
