class Comment < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user
  
  validates :comment, presence: true
  
  def format_created_at
     Date.parse("#{self.created_at}").strftime("%m/%d/%Y")
  end
end
