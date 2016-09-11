class InvalidMoveError < ApiError
  def status_code
    :unprocessable_entity
  end

  def title
    :invalid_move
  end
end
