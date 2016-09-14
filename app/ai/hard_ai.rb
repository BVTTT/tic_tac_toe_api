# frozen_string_literal: true

class HardAI < EasyAI
  attr_reader :player_name

  def initialize(board, player_name: 'cpu')
    super(board)

    # Use the user name to make smart decisions about where to play
    @player_name = player_name
  end

  def available_positions
    board.available_positions.map(&:to_a)
  end

  # Decision is made in this order
  #
  # Try to block or win if possible
  # play in a position that has potential (its inline with a potential win)
  # play in the middle
  # Take a corner
  # Random
  def decide
    corners = [[0, 0], [0, 2], [2, 0], [2, 2]]

    available_corners = available_positions & corners
    middle = available_positions & [[1, 1]]

    find_winning_move_or_block ||
      find_position_with_potential ||
      middle.first ||
      available_corners.sample ||
      super
  end

  def find_winning_move_or_block
    find_in_winning_combination do |combination|
      taken_positions = combination.reject(&:available?)
      unique_positions = taken_positions.uniq { |position| position.value }

      [taken_positions.count, unique_positions.count] == [2, 1]
    end
  end

  def find_position_with_potential
    find_in_winning_combination do |combination|
      has_a_taken_position = combination.any? { |position| position.value == player_name }
      has_a_taken_position && combination.count(&:available?) == 2
    end
  end

  def find_in_winning_combination(&block)
    positions = board.winning_combinations.find(&block)
    positions&.find(&:available?)
  end
end
