class Lifegame
  attr_accessor :row, :column

  def initialize(row, column)
    @row = row
    @column = column
    @table = Array.new(@column).map { Array.new(@row) }
    @next_table = Array.new(@column).map { Array.new(@row) }
  end

  def start
    setup_board
    loop do
      render
      sleep 0.5
      change
      @table = @next_table
      print "\e[#{@column}A"
    end
  end

  private
    def change
      @next_table = Array.new(@column).map { Array.new(@row) }
      @table.each_with_index do |column, column_index|
        column.each_with_index do |row, row_index|
          count = 0
          for c in column_index-1..column_index+1
            for r in row_index-1..row_index+1
              next if c == column_index && r == row_index
              next if c < 0 || c >= @column || r < 0 || r >= @row
              if @table[c][r] == 1
                count += 1
              end
            end
          end
          if @table[column_index][row_index] == 1
            case count
            when 0..1
              @next_table[column_index][row_index] = nil
            when 2..3
              @next_table[column_index][row_index] = 1
            when 4..8
              @next_table[column_index][row_index] = nil
            end
          else
            case count
            when 3
              @next_table[column_index][row_index] = 1
            else
              @next_table[column_index][row_index] = nil
            end
          end
        end
      end
    end

    def render
      @table.each_with_index do |column, column_index|
        column.each_with_index do |row, row_index|
          if @table[column_index][row_index] == 1
            print "+"
          else
            print " "
          end
        end
        print "\n"
      end
    end

    def setup_board
      @table.each_with_index do |column, column_index|
        column.each_with_index do |row, row_index|
          @table[column_index][row_index] = rand(0..1)
        end
      end
    end
end
