Rails.application.routes.draw do
  resources :categories
  resources :projects do
    collection do
      get :in_progress
    end
  end

  root "projects#index"
end
