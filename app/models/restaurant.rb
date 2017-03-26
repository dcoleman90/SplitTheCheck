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
end
