class Lifegame
  autoload :Board, 'board.rb'
  autoload :Cell, 'cell.rb'

  def initialize(width, height)
    @width = width
    @height = height
  end

  def start
    board = Board.new(@width, @height)
    loop do
      board.render
      sleep 0.1
      board.update
      print "\e[#{@height}A"
    end
  end
end
