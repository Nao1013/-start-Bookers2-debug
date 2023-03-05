class Book < ApplicationRecord
  
  belongs_to  :user
  has_many :favorites, dependent: :destroy
  has_many :favorites_users, through: :favorites, source: :user
  has_many :post_comments, dependent: :destroy
  
  # いいねランキング
  has_many :week_favorites, -> { wehere(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }, class_name: 'Favorite'
  
  # 閲覧数
  has_many :view_counts, dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
   def favorited_by?(user)
     self.favorites.exists?(user_id: user.id)
   end
   
end
