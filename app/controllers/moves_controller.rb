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
    validate_user_moves_payload!

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

  def assert_game_is_active!
    if(current_game.is_over?)
      fail InvalidMoveError, %q(Game is over. No more moves are allowed)
    end
  end

  # Simple payload validation
  #
  # This could be done in a much cleaner way with something like JSON Schema
  # But the validation is simple enough so I don't mind implementing it
  def validate_user_moves_payload!
    resource_type = params.dig(:data, :type)
    played_position = params.dig(:data, :attributes, :position)

    unless resource_type === 'user_moves'
      fail PayloadValidationError, 'Invalid resource type at "data.type", expected "user_moves"'
    end

    unless played_position.is_a?(Array) && played_position.length == 2
      fail PayloadValidationError, 'Invalid resource type at "data.attributes.position", expected Array([x, y])'
    end
  end
end
