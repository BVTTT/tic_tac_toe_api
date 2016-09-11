# frozen_string_literal: true

class HomePayload < Serializer
  include LinkGeneration

  def as_json(_context = {})
    {
      links: {
        games: games_url
      }
    }
  end
end
