Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'sessions#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :funds, only: :index
  resources :transactions, only: [:new, :create]
  resources :bank_account, only: [] do
    resources :transaction_history, only: :index
  end
end
