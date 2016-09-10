class ApplicationController < ActionController::API
  respond_to :json
  self.responder = SerializerResponder
end
