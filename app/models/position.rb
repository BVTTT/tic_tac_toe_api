Position = Struct.new(:x, :y, :value) do
  def to_a
    [x, y]
  end
  alias_method :to_ary, :to_a
  alias_method :as_json, :to_a

  def available?
    value.nil?
  end
end

