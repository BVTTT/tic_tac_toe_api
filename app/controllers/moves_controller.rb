# frozen_string_literal: true

class MovesController < ApplicationController
  include CurrentGameAccessors
  before_action LoadGameFilter
  before_action :assert_game_is_active!

  def apply_cpu_move
    assert_correct_player! 'cpu'

    decided_position = current_game.apply_cpu_move!

    respond_with CpuMovesPayload, status: :ok, played_position: decided_position
  end

  def apply_user_move
    assert_correct_player! 'user'
    current_request = UserMovesRequest.new(request)
    current_request.validate!

    if current_game.board.valid_position?(current_request.given_position)
      current_game.make_move! current_request.given_position
    else
      fail InvalidMoveError, %Q(Given position #{current_request.given_position} is out of bounds)
    end

    respond_with GamePayload, status: :ok
  end

  private

  def assert_correct_player!(expected_player)
    if current_game.current_player != expected_player
      fail WrongPlayerError, %Q(It is currently the #{current_game.current_player}'s turn)
    end
  end

  def assert_game_is_active!
    if(current_game.is_over?)
      fail InvalidMoveError, %q(Game is over. No more moves are allowed)
    end
  end
end
