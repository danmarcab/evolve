module Evolve
  module Evolution
    module Operators
      class Selection < Evolve::Evolution::Operators::Base
        def apply(individuals)
          individuals.sort { |ind_a, ind_b| ind_a.fitness <=> ind_b.fitness }.take(individuals.size * 0.5) * 2
        end
      end
    end
  end
end
