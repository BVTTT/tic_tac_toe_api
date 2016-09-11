# frozen_string_literal: true

# AI class that simply chooses a random position to play in
class ImpossibleAI < EasyAI
  attr_reader :player_name

  def initialize(board, player_name: 'cpu')
    super(board)
    @difficulty = 'impossible'

    # Use the user name to make smart decisions about where to play
    @player_name = player_name
  end

  def available_positions
    board.available_positions.map(&:to_a)
  end

  def decide
    corners = [[0, 0], [0, 2], [2, 0], [2, 2]]

    available_corners = available_positions & corners

    position = if available_positions.count.between?(6, 9)
      # First choose a random corner
      available_corners.sample
    elsif available_positions.count.between?(4, 5)
      find_winning_move || available_corners.sample
    else
      find_winning_move
    end

    position || super # Fallback to a more primitive decision
  end

  def find_winning_move
    winning_combination = board.winning_combinations.find do |combination|
      count_played = combination.count { |position| position.value === player_name }

      count_played == 2 && combination.any?(&:available?)
    end

    winning_combination&.find(&:available?)
  end
end
