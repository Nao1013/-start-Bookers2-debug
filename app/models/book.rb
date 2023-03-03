class Book < ApplicationRecord
  
  belongs_to  :user
  has_many :favorites, dependent: :destroy
  has_many :favorites_users, through: :favorites, source: :user
  has_many :post_comments, dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
   def favorited_by?(user)
     self.favorites.exists?(user_id: user.id)
   end
   
  # def self.last_week
    # Book.joins(:favorites).where(favorites: {created_at: 0.days.ago.prev_week..0.days.ago.prev_week(:sunday)}).group(:id).order("count(*) desc")
  # end
   
end
