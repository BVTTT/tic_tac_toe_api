Rails.application.routes.draw do
  scope defaults: { format: :json } do
    resources :games, only: %i( create show destroy )
    put '/games/:id/cpu_moves', to: 'ai#play', as: :cpu_moves
  end
end
