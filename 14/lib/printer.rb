class Printer
  def initialize(grid, out = STDOUT)
    @grid = grid
    @out = out
  end

  def print
    @grid[500, 0] = 'O'

    @grid.grid.each_with_index do |row, i|

      @out.printf "%-7d ", i

      (485..520).each_with_index do |x|
      #row.each_with_index do |cell, x|
        #@out.print x == 500 - @grid.x_diff + 1 ? "\e[32m#{cell}\e[0m" : cell
        cell = row[x] || '.'
        @out.print x == 500 ? "\e[32m#{cell}\e[0m" : cell
      end

      @out.print "\n"
    end
  end
end
