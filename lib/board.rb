class Board
  attr_reader :width, :height, :cells

  def initialize(width, height)
    @width = width
    @height = height
    @cells = initial_cells
  end

  def render
    cells.each_with_index do |h, i|
      h.each_with_index do |w, j|
        if cells[i][j] == 1
          print "+"
        else
          print " "
        end
      end
      print "\n"
    end
  end

  def update
    next_cells = Array.new(width).map { Array.new(height) }
    cells.each_with_index do |h, i|
      h.each_with_index do |w, j|
        count = alive_surrounding_cells_count(i, j)
        if cells[i][j] == 1
          case count
          when 0..1
            next_cells[i][j] = 0
          when 2..3
            next_cells[i][j] = 1
          when 4..8
            next_cells[i][j] = 0
          end
        else
          case count
          when 3
            next_cells[i][j] = 1
          else
            next_cells[i][j] = 0
          end
        end
      end
    end
    @cells = next_cells
  end

  private

  def initial_cells
    cells = Array.new(width).map { Array.new(height) }
    cells.each_with_index do |h, i|
      h.each_with_index do |w, j|
        cells[i][j] = rand(0..1)
      end
    end
  end

  def alive_surrounding_cells_count(y, x)
    count = 0
    for i in y-1..y+1
      for j in x-1..x+1
        next if i == y && j == x
        next if i < 0 || i >= height || j < 0 || j >= width
        if cells[i][j] == 1
          count += 1
        end
      end
    end
    count
  end
end
