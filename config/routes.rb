Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get 'users/:id' => 'users#show', as: :user_profile
  get 'microposts/new' => 'microposts#new', as: :new_micropost
  post 'microposts' => 'microposts#create', as: :microposts
  delete 'microposts/:id' => 'microposts#destroy', as: :delete_micropost
end
