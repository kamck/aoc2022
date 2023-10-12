class Ranger
  def initialize(data)
    @data = sort(data)
  end

  def gaps
    missing = @data.each_cons(2).filter_map do |a, b|
      if a.last < b.first - 1
        start = a.last + 1
        (start...b.first).to_a
      end
    end

    missing.flatten.reject do |m| 
      @data.any? { |d| m.between? d.first, d.last }
    end
  end

  private

    def sort(data)
      data.sort do |a, b|
        r = a.first <=> b.first
        r.zero? ? a.last <=> b.last : r
      end
    end
end
