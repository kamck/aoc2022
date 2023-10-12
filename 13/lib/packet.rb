class Packet
  include Comparable

  def initialize(data)
    @data = data
  end

  def <=>(other_packet)
    compare(@data, other_packet.to_a)
  end

  def to_a
    @data.dup
  end

  private

    def compare(left, right)
      for i in (0..left.size)
        r = compare_by_type(left[i], right[i])
        return r unless r.zero?
      end
      0 # Reached the end without sorting
    end

    def compare_by_type(a, b)
      if [a, b].any? nil
        (a.nil? ? 0 : 1) <=> (b.nil? ? 0 : 1)
      elsif [a, b].all? Integer
        a <=> b
      else
        compare wrap(a), wrap(b)
      end
    end

    def wrap(x) = x.is_a?(Array) ? x : [x]
end
