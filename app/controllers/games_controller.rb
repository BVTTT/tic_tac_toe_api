# frozen_string_literal: true

class GamesController < ApplicationController
  def create
    game = Game.create
    set_location!(game)

    render json: GameSerializer.new(request.env, game), status: :created
  end

  def show
    id = params[:id]
    game = Game.find(id)

    if game
      render json: GameSerializer.new(request.env, game), status: :ok
    else
      render json: NotFoundError.new(%Q(Game with id: #{id.inspect} could not be found)),
        status: :not_found
    end
  end

  private

  def set_location!(game)
    response.location = request.env['url_helper'].url_for(game)
  end
end
