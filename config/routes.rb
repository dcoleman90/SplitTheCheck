Rails.application.routes.draw do
   # on: :member used when :id field needed for action
   resources :restaurants do
   	   get "up_vote", on: :member
   	   get "down_vote", on: :member
   end
   
   #get "/up_vote" => "controller#up_vote", :as => :up_vote
end
