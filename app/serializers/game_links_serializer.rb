class GameLinksSerializer < Serializer
  include CurrentGameAccessors::Reader
  include LinkGeneration

  def as_json(context = {})
    {
      self: url_for(current_game),
      current_player_moves: current_player_move_path
    }
  end

  def current_player_move_path
    return nil if current_game.is_over?

    case current_game.current_player
    when 'cpu'
      cpu_moves_url(current_game)
    else
      user_moves_url(current_game)
    end
  end
end
