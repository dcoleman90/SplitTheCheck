class Restaurant < ApplicationRecord
	def get_city_state_zip
		city_state_zip = self.city + ", " 
			+ self.state + " #{self.zip}"
	end
end
