module Evolve
  module Evolution
    class Runner
      DEFAULT_MAX_GENERATIONS = 1000

      def initialize(options={})
        @fitness_goal = options[:fitness_goal]
        @max_generations = options[:max_generations] || DEFAULT_MAX_GENERATIONS
      end

      def evolve(species)
        until evolution_finished?(species.population) do
          species.population.next_generation!(species.strategy)
        end
        species.population
      end

      def evolution_finished?(population)
        fitness_goal_reached?(population.best_individual.fitness) || max_generations_reached?(population.generation)
      end

      private

      def fitness_goal_reached?(fitness)
        @fitness_goal ? fitness >= @fitness_goal : false
      end

      def max_generations_reached?(generation)
        @max_generations ? @max_generations == generation : false
      end
    end
  end
end
