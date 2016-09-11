class PayloadValidationError < ApiError
  def status_code
    :unprocessable_entity
  end

  def title
    :invalid_payload
  end
end
