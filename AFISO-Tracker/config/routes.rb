Rails.application.routes.draw do

  resources :payments do
    member do
      get :delete
    end
  end


  resources :semesters do
	member do
		get :delete
	end
  end

  resources :members do
	member do
		get :delete
	end
  end

  root to: "home#index"

  get 'home/index'
  get 'home/help'
  get 'home/security'

  #get 'semesters/index'
  #get 'semesters/show'
  #get 'semesters/new'
  #get 'semesters/edit'
  #get 'semesters/delete'
  #get 'members/index'
  #get 'members/show'
  #get 'members/new'
  #get 'members/edit'
  #get 'members/delete'
  #get 'payments/index'
  #get 'payments/show'
  #get 'payments/new'
  #get 'payments/edit'
  #get 'payments/delete'

  mount Lockup::Engine, at: '/lockup'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html



end
