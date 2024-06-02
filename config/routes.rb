Rails.application.routes.draw do
  root "locations#index"
  resources :locations do
    collection do
      post :search
    end
  end
end
