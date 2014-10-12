Rails.application.routes.draw do
  get 'users/:id' => 'users#show'
end
