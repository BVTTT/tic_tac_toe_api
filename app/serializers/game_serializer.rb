class GameSerializer < Serializer
  include CurrentGameAccessors::Reader

  def as_json(context = {})
      {
        type: :games,
        id: current_game.id.to_s,
        attributes: {
          board: current_game.board,
          current_player: current_game.current_player,
          difficulty: current_game.ai.difficulty,
          winner: current_game.winner,
          states: {
            has_winner: current_game.has_winner?,
            is_deadlocked: current_game.is_deadlocked?,
            is_over: current_game.is_over?
          }
        }
      }
  end
end
