# frozen_string_literal: true

class GamesController < ApplicationController
  include CurrentGameAccessors

  before_action LoadGameFilter, only: %i( show destroy )

  def create
    current_request = CreateGameRequest.new(request)
    current_request.validate!

    self.current_game = Game.create current_request.attributes

    respond_with GamePayload, status: :created, location: current_game
  end

  def show
    respond_with GamePayload, status: :ok
  end

  def destroy
    current_game.destroy
    head :no_content
  end
end
