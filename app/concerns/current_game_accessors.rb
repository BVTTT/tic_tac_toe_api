# frozen_string_literal: true

# This module assumes #request.env is defined
module CurrentGameAccessors
  extend ActiveSupport::Concern

  included do
    include Reader
    include Writer
  end

  module Reader
    def current_game
      request.env['current_game']
    end
  end

  module Writer
    def current_game=(game)
      request.env['current_game'] = game
    end
  end
end
