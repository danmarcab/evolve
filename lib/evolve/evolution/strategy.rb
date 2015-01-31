module Evolve
  module Evolution
    class Strategy
      attr_reader :species

      DEFAULT_STEPS = [:selection, :reproduction, :mutation]

      def initialize(species, options={})
        @species = species
        @steps = options[:steps] || DEFAULT_STEPS
        @generation_size = options[:generation_size]
        @fitness_goal = options[:fitness_goal]
        @max_generations = options[:max_generations]
      end

      def initial_generation
        @current_generation = Evolve::Generation.new(@species, size: @generation_size)
      end

      def evolve!
        initial_generation

        until fitness_goal_reached? || max_generations_reached? do
          next_generation!
        end
        @current_generation.best_individual
      end

      def next_generation!
        @steps.each do |step|
          send(step)
        end
        @current_generation.number += 1
      end

      private

      def fitness_goal_reached?
        @fitness_goal ? @current_generation.best_individual.fitness >= @fitness_goal : false
      end

      def max_generations_reached?
        @max_generations ? @max_generations == @current_generation.number : false
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
