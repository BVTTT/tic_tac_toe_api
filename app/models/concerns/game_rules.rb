module GameRules
  module_function

  def find_winner(board)
    winning_combination = board.winning_combinations.find do |set|
      set.all? { |position| !position.available? && position.value == set.first.value }
    end

    winning_combination&.first&.value
  end
end
