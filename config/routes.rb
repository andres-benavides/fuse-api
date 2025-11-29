Rails.application.routes.draw do

 
  get '/specific/:param', to: 'api/v1/test#specific', as: :test_specific

  namespace :api do
    namespace :v1 do
      # Auth
      post 'signup', to: 'auth#signup'
      post 'login',  to: 'auth#login'

      # Listado de compañías para el registro
      resources :companies, only: [:index, :show]

      # Proyectos (solo lectura en esta prueba)
      resources :projects, only: [:index, :show] do
        resources :user_stories, only: [:index, :create]
      end

      # Historias de usuario y tickets
      resources :user_stories, only: [:show] do
        resources :tickets, only: [:index, :create, :update]
      end

      # Historial de tickets (por usuario o por proyecto opcionalmente)
      resources :tickets, only: [:index, :update] do
        member do
          post :cancel
        end
      end
    end
  end

end