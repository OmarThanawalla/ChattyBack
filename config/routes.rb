ChattyBackend::Application.routes.draw do

  resources :user, :conversation, :message, :follow, :follower, :my_conversation, :inner_conversation, :get_message, :search_user, :has_friendship
  
   match ':controller(/:action(/:id(.:format)))'
end
