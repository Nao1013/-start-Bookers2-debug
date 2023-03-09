class Book < ApplicationRecord
  
  belongs_to  :user
  has_many :favorites, dependent: :destroy
  has_many :favorites_users, through: :favorites, source: :user
  has_many :post_comments, dependent: :destroy
  
  # いいねランキング
  has_many :week_favorites, -> { wehere(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }, class_name: 'Favorite'
  
  # 閲覧数
  has_many :view_counts, dependent: :destroy
  
  # 前日比
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
   # 過去７日分の投稿数一覧
  scope :created_2days, -> { where(created_at: 2.days.ago.all_day) }
  scope :created_3days, -> { where(created_at: 3.days.ago.all_day) }
  scope :created_4days, -> { where(created_at: 4.days.ago.all_day) }
  scope :created_5days, -> { where(created_at: 5.days.ago.all_day) }
  scope :created_6days, -> { where(created_at: 6.days.ago.all_day) }
  
  # 前週比
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }
  
 
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
   def favorited_by?(user)
     self.favorites.exists?(user_id: user.id)
   end
   
end
