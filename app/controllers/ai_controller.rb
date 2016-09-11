# frozen_string_literal: true

class AiController < ApplicationController
  include CurrentGameAccessors
  before_action LoadGameFilter
  before_action :assert_correct_player!

  def play
    ai = SimpleAI.new(request)

    ai.play!

    respond_with CpuMovesPayload, status: :ok
  end

  private

  def assert_correct_player!
    if current_game.current_player == 'user'
      fail WrongPlayerError, %q(It is currently the user's turn)
    end
  end
end
