module Evolve
  module Evolution
    class Runner
      DEFAULT_FITNESS_DELTA = 0
      DEFAULT_MAX_GENERATIONS = 1000

      attr_reader :max_generations, :fitness_goal, :fitness_delta

      def initialize(options={})
        if options[:fitness_goal].is_a?(Numeric)
          @fitness_goal = options[:fitness_goal]
          @fitness_delta = options[:fitness_delta] || DEFAULT_FITNESS_DELTA
        end

        @max_generations = options[:max_generations] || DEFAULT_MAX_GENERATIONS
      end

      def evolve(species)
        until evolution_finished?(species.population) do
          puts "best #{species.population.best_individual.genes}"
          puts "Fitness #{species.population.best_individual.fitness}"
          # puts "Population #{species.population.individuals.size}"
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
