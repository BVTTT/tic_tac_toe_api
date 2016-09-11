class UserMovesRequest
  include RequestProcessor

  def resource_type
    params.dig(:data, :type)
  end

  def given_position
    if raw_given_position.respond_to?(:map)
      raw_given_position.map(&:to_i)
    end
  end

  # Simple payload validation
  #
  # This could be done with something like JSON Schema
  # But the validation is simple enough so I don't mind implementing it
  def validate!
    unless resource_type === 'user_moves'
      fail PayloadValidationError, 'Invalid resource type at "data.type", expected "user_moves"'
    end

    unless raw_given_position.is_a?(Array) && raw_given_position.length == 2
      fail PayloadValidationError, 'Invalid resource type at "data.attributes.position", expected Array([x, y])'
    end
  end

  private

  def raw_given_position
    params.dig(:data, :attributes, :position)
  end
end
