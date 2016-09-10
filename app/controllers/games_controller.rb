# frozen_string_literal: true

class GamesController < ApplicationController
  def create
    game = Game.create
    set_location!(game)

    render json: GameSerializer.new(request.env, game),
      status: :created
  end

  private

  def set_location!(game)
    response.location = request.env['url_helper'].url_for(game)
  end
end
