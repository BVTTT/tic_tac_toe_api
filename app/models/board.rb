class Board
  extend Forwardable
  include Enumerable

  class OutOfBoundsError < RuntimeError; end

  Position = Struct.new(:x, :y, :value) do
    def to_a
      [x, y]
    end
    alias_method :to_ary, :to_a

    def available?
      value.nil?
    end
  end

  class << self
    # Mongoid callbacks
    # See https://docs.mongodb.com/ruby-driver/master/tutorials/mongoid-documents/#custom-fields
    def mongoize(object)
      if object.respond_to?(:as_json)
        object.as_json
      else
        object
      end
    end
    alias_method :evolve, :mongoize

    def demongoize(object)
      Board.new(rows: object.dup)
    end
  end

  attr_reader :rows
  def_delegator :rows, :size

  def initialize(size: 3, rows: Array.new(size) { Array.new(size) })
    @rows = rows
  end

  def as_json(context = {})
    rows
  end

  alias_method :mongoize, :as_json

  def []=(x, y, new_value)
    unless valid_position?([x, y])
      fail OutOfBoundsError, "Given position([#{x}, #{y}]) is out of bounds"
    end

    rows[y][x] = new_value
  end

  def [](x, y)
    rows[y][x]
  end

  def winning_combinations
    [*rows, *columns, *diagonals]
  end

  def each
    return to_enum(:each) unless block_given?

    rows.each.with_index do |row, y|
      row.each.with_index do |value, x|
        yield Position.new(x, y, value)
      end
    end
  end

  def available_positions
    select(&:available?)
  end

  def unavailable_positions
    reject(&:available?)
  end

  def columns
    rows.transpose
  end

  # There is definitely a fancier way to do this using ruby's enumerator class and enumerable module
  #
  # However, I found that implementing an old fashioned while loop was clearer
  def diagonals
    top_iterator = 0
    bottom_iterator = -1

    from_top, from_bottom = [], []

    while(top_iterator < rows.length)
      top_row = rows[top_iterator]
      bottom_row = rows[bottom_iterator]

      from_top[top_iterator] = top_row[top_iterator]
      from_bottom[top_iterator] = bottom_row[top_iterator]

      top_iterator += 1
      bottom_iterator -= 1
    end

    [from_top, from_bottom]
  end

  def valid_position?(position)
    x, y = position
    x.between?(0, size - 1) && y.between?(0, size - 1) && self[x, y].nil?
  end
end
