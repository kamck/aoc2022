require 'test/unit'
require_relative '../lib/border'

class TestBorder < Test::Unit::TestCase
  def test_line_southeast
    expected = [[1, 2], [2, 3], [3, 4], [4, 5]]
    border = Border.new([1, 2], [4, 5])
    assert_equal expected, border.line
  end

  def test_line_southwest
    expected = [[2, 4], [3, 3], [4, 2], [5,1]]
    border = Border.new([5, 1], [2, 4])
    assert_equal expected, border.line
  end

  def test_line_northeast
    expected = [[1, 7], [2, 6], [3, 5]]
    border = Border.new([1, 7], [3, 5])
    assert_equal expected, border.line
  end

  def test_line_northwest
    expected = [[4, 1], [5, 2], [6, 3], [7, 4]]
    border = Border.new([7, 4], [4, 1])
    assert_equal expected, border.line
  end

  def test_overlap
    a = Border.new([7, 4], [4, 1])
    b = Border.new([6, 3], [8, 5])
    assert_equal [[6, 3], [7, 4]], a.overlap(b)
  end

  def test_blah
    assert_equal [], Border.new([8, 14], [12, 10]).line
  end
end
