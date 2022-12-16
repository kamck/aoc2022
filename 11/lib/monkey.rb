class Monkey
  attr_reader :items, :inspection_count

  def initialize(items, op, test)
    @items = items
    @op = op
    @test = test
    @inspection_count = 0
  end

  def inspect_items
    @items.map! { |i| @op.calc(i) }
    @inspection_count += @items.size
  end

  def throw_items
    while !@items.empty? do
      result = @items.first % @test[:div] == 0
      yield @test[result], @items.shift
    end
  end

  def catch_item(item) = @items << item

  def test_val = @test[:div]
end
