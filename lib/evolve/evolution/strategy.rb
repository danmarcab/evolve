module Evolve
  module Evolution
    class Strategy
      attr_reader :species

      DEFAULT_STEPS = [:selection, :reproduction, :mutation]

      def initialize(species, options={})
        @species = species
        @steps = options[:steps] || DEFAULT_STEPS
        @population_size = options[:population_size]
        @fitness_goal = options[:fitness_goal]
        @max_generations = options[:max_generations]
      end

      def initial_population
        @population = Evolve::Population.new(@species, size: @population_size)
      end

      def evolve!
        initial_population

        until fitness_goal_reached? || max_generations_reached? do
          next_generation!
        end
        @population
      end

      def next_generation!
        @steps.each do |step|
          send(step)
        end
        @population.generation += 1
      end

      private

      def fitness_goal_reached?
        @fitness_goal ? @population.best_individual.fitness >= @fitness_goal : false
      end

      def max_generations_reached?
        @max_generations ? @max_generations == @population.generation : false
      end

      def selection
      end

      def reproduction
      end

      def mutation
      end
    end
  end
end
