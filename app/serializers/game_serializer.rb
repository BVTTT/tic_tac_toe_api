class GameSerializer
  def initialize(game)
    @game = game
  end

  def as_json(context = {})
    {
      data: {
        type: "games",
        id: @game.id.to_s,
        attributes: {
          board: @game.board
        }
      }
    }
  end
end
