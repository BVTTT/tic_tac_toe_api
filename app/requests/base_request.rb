class BaseRequest
  include RequestProcessor

  def resource_type
    params.dig(:data, :type)
  end
end
