Rails.application.routes.draw do
   # on: :member used when :id field needed for action
   resources :restaurants do
   	   patch "up_vote", on: :member
   	   patch "down_vote", on: :member
   end
   
   get 'admin' => 'admin#index'

   controller :sessions do
  	   get  'login'  => :new
  	   post 'login'  => :create
  	   delete 'logout' => :destroy
   end

   resources :users
end
