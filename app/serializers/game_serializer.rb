class GameSerializer
  attr_reader :url_helper, :game
  def initialize(env, game)
    @url_helper = env['url_helper']
    @game = game
  end

  def as_json(context = {})
    {
      data: {
        type: "games",
        id: game.id.to_s,
        attributes: {
          board: game.board
        }
      },
      links: {
        self: url_helper.url_for(game)
      }
    }
  end
end
