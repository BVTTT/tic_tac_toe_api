class Game
  include Mongoid::Document

  field :board, type: Array, default: -> { Game.new_board }

  def self.new_board
    Array.new(3) { Array.new(3) }
  end
end
