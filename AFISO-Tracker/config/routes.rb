Rails.application.routes.draw do
  mount Lockup::Engine, at: '/lockup'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
