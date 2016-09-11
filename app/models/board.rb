class Board
  extend Forwardable

  class OutOfBoundsError < RuntimeError; end

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
      Board.new(rows: object)
    end
  end

  def initialize(size: 3, rows: Array.new(size) { Array.new(size) })
    @rows = rows
  end

  def as_json(context = {})
    rows
  end

  def []=(x, y, new_value)
    unless valid_position?(x, y)
      fail OutOfBoundsError, "Given [#{x}, #{y}]"
    end

    rows[y][x] = new_value
  end

  def [](x, y)
    rows[y][x]
  end

  def winning_combinations
    [*rows, *columns, *diagonals]
  end

  def available_positions
    rows.each.with_object([]).with_index do |(row, list), row_index|
      row.each_with_index do |value, column_index|
        if(value.nil?)
          list.push([column_index, row_index])
        end
      end
    end
  end

  private

  attr_reader :rows
  def_delegator :rows, :size

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

  def valid_position?(x, y)
    x.between?(0, size - 1) && y.between?(0, size - 1) && self[x, y].nil?
  end
end
