class ApiError < Exception
  def as_json(context = {})
    {
      errors: [
        {
          title: title,
          detail: message,
          status_code: status_code
        }
      ]
    }
  end
end
