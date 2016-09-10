# frozen_string_literal: true

# The intent of this middleware is to provide a simple object to the
# application which facilitates generating urls.
#
# The alternative (Which made me feel dirty) was use the controller as this
# object. This would work because the controller is configured to use the
# request host for generating urls. However, this added a 'tangled' feeling
# to the app as the controller is the most important component in the app design.
class UrlHelperMiddleware
  class UrlHelper
    include Rails.application.routes.url_helpers

    def initialize(host)
      @host = host
    end

    def default_url_options
      {host: @host}
    end
  end

  def initialize(app)
    @app = app
  end

  def call(env)
    host = env.fetch('HTTP_HOST') { 'localhost' }

    env['url_helper'] = UrlHelper.new(host)
    @app.call(env)
  end
end
