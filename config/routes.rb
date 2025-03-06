Rails.application.routes.draw do
  get '/' => 'home#index'
  post '/chat/send_message', to: 'chat#send_message'
end
