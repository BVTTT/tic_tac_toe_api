# frozen_string_literal: true

# AI class that simply chooses a random position to play in
class SimpleAI
  extend Forwardable
  include CurrentGameAccessors::Reader

  attr_reader :request
  def initialize(request)
    @request = request
  end

  def decide
    board.available_positions.sample
  end

  def play!
    position = decide
    current_game.make_move! position
    current_game.save

    request.env['ai.played_position'] = position
  end

  private

  def_delegator :current_game, :board
end
