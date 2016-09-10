Rails.application.routes.draw do
  scope defaults: { format: :json } do
    resources :games, only: [:create, :show, :destroy]
  end
end
