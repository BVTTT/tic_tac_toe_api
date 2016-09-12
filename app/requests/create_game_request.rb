# frozen_string_literal: true

class CreateGameRequest < BaseRequest
  include RequestProcessor

  def desired_ai_class_name
    case difficulty
    when 'easy'
      'EasyAI'
    when 'impossible'
      'ImpossibleAI'
    end
  end

  def difficulty
    params.dig(:data, :attributes, :difficulty)
  end

  def validate!
    unless resource_type === 'games'
      fail PayloadValidationError, 'Invalid resource type at "data.type", expected "games"'
    end

    unless difficulty.in? %w( easy impossible )
      fail PayloadValidationError, 'Invalid resource type at "data.attributes.difficulty", expected "easy" or "impossible"'
    end
  end
end
