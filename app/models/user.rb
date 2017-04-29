class User < ApplicationRecord
  has_and_belongs_to_many :restaurants
  
  validates :name, :email, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: Devise::email_regexp
  has_secure_password
  
  def self.has_favorites?(history)
	 count = 0
     history.each do |h|
      count = count + h.up_votes_added
     end
     
     if count == 0
       return false
     else
       return true
     end
  end
end
