class Game
  PLAYERS = %w( cpu user )

  include Mongoid::Document

  field :board, type: Board, default: -> { Board.new }
  field :current_player, type: String, default: 'cpu'

  def make_move!(position)
    x, y = position
    board[x, y] = current_player
    self.current_player = next_player
  end

  def next_player
    (PLAYERS - [current_player]).first
  end
end
