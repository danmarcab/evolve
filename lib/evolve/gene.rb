module Evolve
  class Gene
    attr_reader :name

    def initialize(name, options={})
      @name = name
      @range = options[:range]
      @values = options[:values]
    end

    def sample
      case
      when @values
        @values.sample
      when @range
        rand(@range)
      end
    end

    def combine(value_a, value_b)
      [value_b, value_a]
    end
  end
end
