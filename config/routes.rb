Exchange::Application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resources :identities, :only => [:create]
    end
  end
  
  resources :api_keys, :except => [:new, :edit, :update]

  root :to => "static_page#home"

  match 'copyright', :to => 'static_page#copyright'
end