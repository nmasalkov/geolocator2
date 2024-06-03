Rails.application.routes.draw do
  root "locations#index"
  resources :locations do
    collection do
      post :index
      post :search
    end
  end
end
