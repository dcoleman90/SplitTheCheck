Rails.application.routes.draw do
   # on: :member used when :id field needed for action
   resources :restaurants do
   	   post "up_vote", on: :member
   	   post "down_vote", on: :member
   end
end
