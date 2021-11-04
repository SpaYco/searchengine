Rails.application.routes.draw do
  get 'search/index'
  resources 'article', only: [:index]
  get "/search", to: "search#index"
  post 'article/search', to: 'article#search'
  root 'article#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
