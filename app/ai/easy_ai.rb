# frozen_string_literal: true

# AI class that simply chooses a random position to play in
class EasyAI
  attr_reader :board, :difficulty
  def initialize(board)
    @board = board
    @difficulty = 'easy'
  end

  def decide
    board.available_positions.sample.to_a
  end
end
