Rails.application.routes.draw do
  get 'searches/search'
  devise_for :users, controllers: {
  sessions: 'users/sessions',
  registrations: 'users/registrations'
}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  get "search" => "searches#search"
  resources :users do
    get "users/follows" => "users#follows"
    get "users/followers" => "users#followers"
    resource :relationships, only: [:create, :destroy]
  end
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
end
