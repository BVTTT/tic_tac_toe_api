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
end
