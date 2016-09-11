class NotFoundError < ApiError
  def status_code
    :not_found
  end

  def title
    :not_found
  end
end
