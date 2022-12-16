class Display
  WIDTH = 40
  HEIGHT = 6

  def initialize(out = STDOUT)
    @out = out
    @x = @y = 0
  end

  def tick(reg_x)
    @out.print pixel_lit?(reg_x) ? '#' : '.'
    @x += 1
    reset_x if @x == WIDTH
    reset_y if @y == HEIGHT
  end

  private

    def pixel_lit?(reg_x) = reg_x && (reg_x - @x).abs <= 1

    def reset_x
      @out.print "\n"
      @y += 1
      @x = 0
    end

    def reset_y
      @out.print "\n\n"
      @y == 0
    end
end
