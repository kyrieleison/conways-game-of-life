require 'cells'

class Board
  attr_reader :width, :height, :cells

  def initialize(width, height)
    @width = width
    @height = height
    @cells = Cells.new(width, height)
  end

  def render
    cells.render
  end

  def update
    cells.each_by_cell do |cell, i, j|
      count = alive_surrounding_cells_count(i, j)
      if cell.live?
        case count
        when 0..1
          cell.dead!
        when 2..3
          cell.live!
        when 4..8
          cell.dead!
        end
      else
        case count
        when 3
          cell.live!
        else
          cell.dead!
        end
      end
    end
  end

  private

  def alive_surrounding_cells_count(current_column, current_row)
    count = 0
    for i in current_column - 1..current_column + 1
      for j in current_row - 1..current_row + 1
        next if current?(i, j, current_column, current_row)
        next if outside?(i, j)
        if cells.cell(i, j).live?
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
