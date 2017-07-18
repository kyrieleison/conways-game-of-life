require 'cell'

class Cells
  attr_reader :width, :height, :cells

  def initialize(width, height)
    @width = width
    @height = height
    @cells = initial_cells
  end

  def initial_cells
    cells = Array.new(width).map { Array.new(height) }
    cells.each_with_index do |h, i|
      h.each_with_index do |w, j|
        cells[i][j] = Cell.randomly_create
      end
    end
    cells
  end

  def cell(x, y)
    cells[y][x]
  end

  def each_by_cell
    for i in 0...cells.length
      for j in 0...cells[i].length
        yield cell(i, j), i, j
      end
    end
  end

  def render
    for i in 0...cells.length
      for j in 0...cells[i].length
        if cell(i, j).live?
          print "+"
        else
          print " "
        end
      end
      print "\n"
    end
  end
end
