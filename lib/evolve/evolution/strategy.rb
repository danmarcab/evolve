module Evolve
  module Evolution
    class Strategy
      attr_reader :species

      DEFAULT_STEPS = [:selection, :reproduction, :mutation]

      def initialize(options={})
        @steps = options[:steps] || DEFAULT_STEPS
        @fitness_goal = options[:fitness_goal]
        @max_generations = options[:max_generations]
      end

      def next_generation(individuals)
        @steps.each do |step|
          individuals = send(step, individuals)
        end
        individuals
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

      def selection(individuals)
        individuals
      end

      def reproduction(individuals)
        individuals
      end

      def mutation(individuals)
        individuals
      end
    end
  end
end
