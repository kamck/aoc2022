Operation = Struct.new(:term1, :operator, :term2) do
  def calc(val)
    a = term1 == 'old' ? val : term1.to_i
    b = term2 == 'old' ? val : term2.to_i
    a.send(operator.to_sym, b)
  end
end
