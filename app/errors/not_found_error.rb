class NotFoundError
  def initialize(env)
    @env = env
  end

  def as_json(context = {})
    {
      errors: [
        {
          title: :not_found,
          detail: context[:message]
        }
      ]
    }
  end
end
