Rails.application.routes.draw do
  resources 'article', only: [:index]
  resources 'search', only: [:index]
  get 'article/search', to: 'article#search'
  root 'article#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
