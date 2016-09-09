class GamesController < ApplicationController
  def create
    game = Game.create

    render json: GameSerializer.new(game), location: game, status: 201
  end
end
