# frozen_string_literal: true

class GamePayload < Serializer
  def as_json(context = {})
    {
      data: GameSerializer.new(request),
      links: GameLinksSerializer.new(request)
    }
  end
end
