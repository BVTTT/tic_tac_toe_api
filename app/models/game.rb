class Game
  PLAYERS = %w( cpu user )

  include Mongoid::Document

  field :board, type: Board, default: -> { Board.new }
  field :current_player, type: String, default: 'cpu'
  field :ai_class_name, type: String, default: 'EasyAI'

  def make_move!(position)
    board_will_change!

    x, y = position
    board[x, y] = current_player
    self.current_player = next_player

    save
  end

  def next_player
    (PLAYERS - [current_player]).first
  end

  def apply_cpu_move!
    decided_position = ai.decide

    make_move! decided_position

    decided_position
  end

  def ai
    Object.const_get(ai_class_name).new(board)
  end

  def has_winner?
    !winner.nil?
  end

  def is_deadlocked?
    !has_winner? && board.available_positions.none?
  end

  def is_over?
    has_winner? || is_deadlocked?
  end

  def winner
    winning_combination = board.winning_combinations.find do |set|
      set.all? { |element| !element.nil? && element == set.first }
    end

    winning_combination&.first
  end
end
