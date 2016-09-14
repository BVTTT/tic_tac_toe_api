module FirstPlayerStrategy
  module_function

  def call
    strategy = Settings.game.first_player_strategy
    case strategy
    when 'random'
      -> { %w( cpu user ).sample }
    else
      strategy
    end
  end
end
