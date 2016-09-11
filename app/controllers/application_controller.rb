class ApplicationController < ActionController::API
  respond_to :json
  self.responder = SerializerResponder

  rescue_from ApiError do |error|
    render json: error, status: error.status_code
  end

  def home
    respond_with HomePayload, status: :ok
  end

  def endpoint_missing
    fail EndpointNotImplementedError, 'The requested endpoint is not implemented'
  end
end
