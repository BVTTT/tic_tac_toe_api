class NotFoundError
  attr_reader :message
  def initialize(message)
    @message = message
  end

  def as_json(context = {})
    {
      errors: [
        {
          title: :not_found,
          detail: message
        }
      ]
    }
  end
end
