Rails.application.routes.draw do
  
  resources :payments do
    member do
      get :delete
    end
  end
  
  #get 'payments/index'
  #get 'payments/show'
  #get 'payments/new'
  #get 'payments/edit'
  #get 'payments/delete'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
