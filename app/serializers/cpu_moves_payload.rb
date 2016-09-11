# frozen_string_literal: true

class CpuMovesPayload < Serializer
  def as_json(context = {})
    {
      data: GameSerializer.new(request),
      links: GameLinksSerializer.new(request),
      related: {
        cpu_moves: {
          played_position: request.env['ai.played_position']
        }
      }
    }
  end
end
