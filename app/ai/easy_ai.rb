# frozen_string_literal: true

# AI class that simply chooses a random position to play in
class EasyAI
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def decide
    board.available_positions.sample
  end
end
