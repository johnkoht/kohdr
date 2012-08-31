Kohdr::Application.routes.draw do
    
  # Devise with Facebook Integration
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
     get "logout" => "devise/sessions#destroy"
  end  
  
  
  root :to => 'application#index'
  
  match "dashboard", :to => "authenticated#index"
  
end
