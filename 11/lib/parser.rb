require_relative 'monkey'
require_relative 'operation'

class Parser
  class << self
    def parse(lines)
      x = {}

      lines.map do |line|
        case line
        when /Starting items/
          x[:items] = get_value(line).split(', ').map(&:to_i)
        when /Operation/
          x[:op] = parse_operation(get_value(line))
        when /Test/
          x[:div] = get_last(line)
        when /If true/
          x[true] = get_last(line)
        when /If false/
          x[false] = get_last(line)
        end
      end

      Monkey.new(*x.values_at(:items, :op), x.slice(:div, true, false))
    end

    private

      def get_value(line)
        line.split(': ').last.chomp 
      end

      def parse_operation(line)
        Operation.new(*line.split('= ').last.split)
      end

      def get_last(line)
        get_value(line).split.last.to_i
      end
  end
end
