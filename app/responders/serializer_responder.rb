class SerializerResponder < ActionController::Responder
  alias_method :serializer_class, :resource

  def to_json
    render json: serializer_class.new(request), **options
  end
end
