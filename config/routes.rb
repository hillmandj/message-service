Rails.application.routes.draw do
  get 'messages/:digest' => 'messages#show'
  post 'messages/' => 'messages#create'
end
