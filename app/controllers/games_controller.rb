# frozen_string_literal: true

class GamesController < ApplicationController
  before_action :load_game!, only: [:show, :destroy]

  def create
    self.current_game = Game.create

    respond_with GameSerializer, status: :created, location: current_game
  end

  def show
    if current_game
      respond_with GameSerializer, status: :ok
    else
      fail_with_not_found!
    end
  end

  def destroy
    if current_game
      current_game.destroy
      head :no_content
    else
      fail_with_not_found!
    end
  end

  private

  def load_game!
    self.current_game = Game.find(requested_game_id)
  end

  def requested_game_id
    params[:id]
  end

  def current_game=(game)
    request.env['current_game'] = game
  end

  def current_game
    request.env['current_game']
  end

  def fail_with_not_found!
    respond_with NotFoundError,
      message: %Q(Game with id: #{requested_game_id.inspect} could not be found),
      status: :not_found
  end
end
