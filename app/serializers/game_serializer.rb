class GameSerializer < Serializer
  include CurrentGameAccessors::Reader

  def as_json(context = {})
      {
        type: :games,
        id: current_game.id.to_s,
        attributes: {
          board: current_game.board,
          current_player: current_game.current_player,
          difficulty: current_game.ai.difficulty
        }
      }
  end
end
