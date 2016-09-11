# frozen_string_literal: true

Rails.application.routes.draw do
  scope defaults: { format: :json } do
    resources :games, only: %i( create show destroy )

    put '/games/:id/cpu_moves', to: 'moves#apply_cpu_move', as: :cpu_moves
    put '/games/:id/user_moves', to: 'moves#apply_user_move', as: :user_moves

    root to: 'application#home'
  end
end
