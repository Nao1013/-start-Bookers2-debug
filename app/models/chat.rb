class Chat < ApplicationRecord
  
  belongs_to :user
  belongs_to :room

valodates :message, presence: true, length: { maximum: 140 }
  
end
