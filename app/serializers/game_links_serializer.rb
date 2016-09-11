class GameLinksSerializer < Serializer
  include CurrentGameAccessors::Reader
  include Rails.application.routes.url_helpers

  def as_json(context = {})
    {
      self: url_for(current_game),
      current_player_moves: current_player_move_path
    }
  end

  def default_url_options
    {host: request.host}
  end

  def current_player_move_path
    case current_game.current_player
    when 'cpu'
      cpu_moves_path(current_game)
    else
      '' # Empty for now
    end
  end
end
