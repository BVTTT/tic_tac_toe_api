# frozen_string_literal: true

class MovesController < ApplicationController
  include CurrentGameAccessors
  before_action LoadGameFilter

  def apply_cpu_move
    assert_correct_player! 'cpu'

    decided_position = current_game.apply_cpu_move!

    respond_with CpuMovesPayload, status: :ok, played_position: decided_position
  end

  def apply_user_move
    assert_correct_player! 'user'

    given_position = params.dig(:data, :attributes, :position).map(&:to_i)

    if current_game.board.valid_position?(given_position)
      current_game.make_move! given_position
    else
      fail InvalidMoveError, %Q(Given position #{given_position} is out of bounds)
    end

    respond_with GamePayload, status: :ok
  end

  private

  def assert_correct_player!(expected_player)
    if current_game.current_player != expected_player
      fail WrongPlayerError, %Q(It is currently the #{current_game.current_player}'s turn)
    end
  end
end
