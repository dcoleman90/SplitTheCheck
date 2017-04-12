Rails.application.routes.draw do
   # on: :member used when :id field needed for action
   resources :restaurants do
   	   patch "up_vote", on: :member
   	   patch "down_vote", on: :member
   end
end
