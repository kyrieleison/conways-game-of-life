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
        if live?(cells[i][j])
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
        if live?(cells[i][j])
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
        cells[i][j] = rand(dead..live)
      end
    end
  end

  def alive_surrounding_cells_count(y, x)
    count = 0
    for i in y-1..y+1
      for j in x-1..x+1
        next if current?(i, j, y, x)
        next if outside?(i, j)
        if live?(cells[i][j])
          count += 1
        end
      end
    end
    count
  end

  def current?(y, x, current_column, current_row)
    y == current_column && x == current_row
  end

  def outside?(y, x)
    y < 0 || y >= height || x < 0 || x >= width
  end

  def live
    1
  end

  def dead
    0
  end

  def live?(cell)
    cell == live
  end

  def dead?(cell)
    cell == dead
  end

  def live!(cell)
    cell = live
  end

  def dead!(cell)
    cell = dead
  end
end
