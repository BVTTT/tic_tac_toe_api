# frozen_string_literal: true

module LinkGeneration
  extend ActiveSupport::Concern

  included do
    include Rails.application.routes.url_helpers
  end

  def default_url_options
    {host: request.host}
  end
end
