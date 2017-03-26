class Restaurant < ApplicationRecord
	def get_city_state_zip
		city_state_zip = self.city + ", " + self.state + " #{self.zip}"
	end
	
	def add_up_vote
		self.up_votes = self.up_votes + 1;
	end
	
	def add_down_vote
		self.down_votes = self.down_votes + 1;
	end
	
	def self.search(search)
		if !search.blank? 
		 return where("name LIKE ? OR address LIKE ? OR City LIKE ? OR state LIKE ? OR zip LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
		end
	end
end
