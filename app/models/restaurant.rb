class Restaurant < ApplicationRecord
	has_and_belongs_to_many :users
	
	def get_city_state_zip
		city_state_zip = self.city + ", " + self.state + " #{self.zip}"
	end
	
	def self.search(search)
		if !search.blank? 
		 return where("name LIKE ? OR address LIKE ? OR City LIKE ? OR state LIKE ? OR zip LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
		end
	end
	
	validates :name, :address, :city, :state, :zip, 
		presence: true
		
	validates :state, length: { is: 2 }
	
	validates :zip,	numericality: { only_integer: true, 
		greater_than_or_equal_to: 501 }
end
