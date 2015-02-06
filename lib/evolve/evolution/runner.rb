module Evolve
  module Evolution
    class Runner
      DEFAULT_MAX_GENERATIONS = 1000

      def initialize(options={})
        if options[:fitness_goal].is_a?(Numeric)
          @fitness_goal = options[:fitness_goal]
          @fitness_delta = options[:fitness_delta] || 0
        end

        @max_generations = options[:max_generations] || DEFAULT_MAX_GENERATIONS
      end

      def evolve(species)
        until evolution_finished?(species.population) do
          species.next_generation!
        end
      end

      def evolution_finished?(population)
        fitness_goal_reached?(population.best_individual.fitness) || max_generations_reached?(population.generation)
      end

      private

      def fitness_goal_reached?(fitness)
        if @fitness_goal
          (@fitness_goal - fitness).abs <= @fitness_delta
        else
          false
        end
      end

      def max_generations_reached?(generation)
        @max_generations ? @max_generations == generation : false
      end
    end
  end
end
