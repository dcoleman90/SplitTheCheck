Rails.application.routes.draw do
  resources :comments
   resources :users
   resources :histories
   
   resources :restaurants do 
   	  get "up_vote", on: :member
   	  get "down_vote", on: :member
   end 
   
   controller :histories do
   	   get "up_vote"
   	   get "down_vote"
   end
   
   get "admin" => 'admin#index'

   controller :sessions do
  	   get  "login"  => :new
  	   post "login"  => :create
  	   delete "logout" => :destroy
   end

   # on: :member used when :id field needed for action
end
