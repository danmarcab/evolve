module Evolve
  module Evolution
    module Operators
      class Mutation < Evolve::Evolution::Operators::Base
        def apply(individuals)
          random_individual = individuals.shuffle.first
          random_gene = random_individual.genes.keys.shuffle.first
          random_individual.genes[random_gene] = random_individual.class.genes[random_gene].sample

          individuals
        end
      end
    end
  end
end
