Position = Struct.new(:x, :y) do
	def up = Position.new(self.x, self.y + 1)
	def down = Position.new(self.x, self.y - 1)
	def left = Position.new(self.x - 1, self.y)
	def right = Position.new(self.x + 1, self.y)
end
