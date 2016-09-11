module RequestProcessor
  extend Forwardable

  def_delegator :@request, :params

  attr_reader :request
  def initialize(request)
    @request = request
  end
end
