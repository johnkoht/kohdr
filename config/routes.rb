Kohdr::Application.routes.draw do
    
  # Devise with Facebook Integration
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
     get "logout" => "devise/sessions#destroy"
  end  
  
  match "dashboard", :to => "authenticated#index"
  
  
  
  root :to => 'application#index'
  
  
  
  # the Admin                                                                   (http://www.domain.com/admin)
  # ---------------------------------------------------------------------------------------------------------
  
  namespace :admin do
  
    root :to => "users#index"
    
    resources :users do
      collection do
        get :admins
        get :deleted
      end
      member do
        get :delete
        get :undelete
      end
    end
    
    
  end
  
end
