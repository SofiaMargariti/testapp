Rails.application.routes.draw do
  get 'sessions/new'

  resources :vessels, except: :show

  namespace :admin do
    resources :vessels, except: :show
  end

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  root to: 'vessels#index'
end
