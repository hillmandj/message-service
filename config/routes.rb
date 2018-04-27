Rails.application.routes.draw do
  get 'messages/:token' => 'messages#show'
  post 'messages/' => 'messages#create'
end
