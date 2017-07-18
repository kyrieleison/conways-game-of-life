require 'cell'

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
        if cells[i][j].live?
          print "+"
        else
          print " "
        end
      end
      print "\n"
    end
  end

  def update
    cells.each_with_index do |h, i|
      h.each_with_index do |w, j|
        count = alive_surrounding_cells_count(i, j)
        if cells[i][j].live?
          case count
          when 0..1
            cells[i][j].dead!
          when 2..3
            cells[i][j].live!
          when 4..8
            cells[i][j].dead!
          end
        else
          case count
          when 3
            cells[i][j].live!
          else
            cells[i][j].dead!
          end
        end
      end
    end
  end

  private

  def initial_cells
    cells = Array.new(width).map { Array.new(height) }
    cells.each_with_index do |h, i|
      h.each_with_index do |w, j|
        cells[i][j] = Cell.randomly_create
      end
    end
  end

  def alive_surrounding_cells_count(y, x)
    count = 0
    for i in y-1..y+1
      for j in x-1..x+1
        next if current?(i, j, y, x)
        next if outside?(i, j)
        if cells[i][j].live?
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
end
