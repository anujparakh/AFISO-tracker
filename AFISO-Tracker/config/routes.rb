Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
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
end
