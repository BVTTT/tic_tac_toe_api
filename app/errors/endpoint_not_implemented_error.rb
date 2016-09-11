class EndpointNotImplementedError < ApiError
  def status_code
    :not_implemented
  end

  def title
    :not_implemented
  end
end
