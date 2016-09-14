# frozen_string_literal: true

class Game
  PLAYERS = %w( cpu user )

  include Mongoid::Document

  field :board, type: Board, default: -> { Board.new }
  field :current_player, type: String, default: FirstPlayerStrategy.call
  field :difficulty, type: String, default: 'easy'

  # Applies a move for the current player
  def apply_move!(position)
    board_will_change!

    x, y = position
    board[x, y] = current_player
    self.current_player = next_player

    save
  end

  def apply_ai_driven_move!
    decided_position = ai.decide

    apply_move! decided_position

    decided_position
  end

  def ai_class
    case difficulty
    when 'easy'
      EasyAI
    else
      HardAI
    end
  end

  def ai
    ai_class.new(board)
  end

  def next_player
    (PLAYERS - [current_player]).first
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
    GameRules.find_winner(board)
  end
end
