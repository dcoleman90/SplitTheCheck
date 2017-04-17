class Comment < ApplicationRecord
  belongs_to :restaurant
  belongs_to :users
  
  validates :comments, presence: true
end
