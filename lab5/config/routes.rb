Rails.application.routes.draw do
  resources :team_members
  resources :categories
  resources :projects do
    collection do
      get :in_progress
      get :deadline_soon
    end
  end

  root "projects#index"
end
