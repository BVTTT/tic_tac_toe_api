# frozen_string_literal: true

class GameSerializer
  include Rails.application.routes.url_helpers
  attr_reader :request

  def initialize(request)
    @request = request
  end

  def as_json(context = {})
    game = request.env.fetch('current_game')

    {
      data: {
        type: :games,
        id: game.id.to_s,
        attributes: {
          board: game.board,
          current_player: game.current_player
        }
      },
      links: {
        self: url_for(game)
      }
    }
  end

  private

  def default_url_options
    {host: request.host}
  end
end
