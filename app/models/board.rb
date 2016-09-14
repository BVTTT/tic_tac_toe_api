class Board
  extend Forwardable
  include Enumerable

  class OutOfBoundsError < RuntimeError; end

  class << self
    # Mongoid callbacks
    def mongoize(object)
      if object.respond_to?(:as_json)
        object.as_json
      else
        object
      end
    end
    alias_method :evolve, :mongoize

    def demongoize(object)
      Board.new(grid: object.dup)
    end
  end

  attr_reader :grid
  def_delegator :grid, :size

  def initialize(size: 3, grid: Array.new(size) { Array.new(size) })
    @grid = grid
  end

  def as_json(context = {})
    grid
  end

  def []=(x, y, new_value)
    unless valid_position?([x, y])
      fail OutOfBoundsError, "Given position([#{x}, #{y}]) is out of bounds"
    end

    grid[y][x] = new_value
  end

  def [](x, y)
    grid[y][x]
  end

  def winning_combinations
    [*rows, *columns, *diagonals]
  end

  def each
    return to_enum(:each) unless block_given?

    each_row do |row|
      row.each { |position| yield position }
    end
  end

  def each_row
    return to_enum(:each_row) unless block_given?

    grid.each.with_index do |row, y|
      positions = row.map.with_index do |value, x|
        Position.new(x, y, value)
      end

      yield positions
    end
  end

  def rows
    each_row.to_a
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

    while(top_iterator < grid.length)
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
