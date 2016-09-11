class WrongPlayerError < ApiError
  def status_code
    :unprocessable_entity
  end

  def title
    :wrong_player
  end
end
