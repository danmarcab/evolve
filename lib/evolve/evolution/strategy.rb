module Evolve
  module Evolution
    class Strategy

      DEFAULT_STEPS = [:selection, :reproduction, :mutation]
      DEFAULT_FITNESS_GOAL = :bigger_better

      def initialize(options={})
        @steps = options[:evolution_steps] || DEFAULT_STEPS
        @fitness_goal = options[:fitness_goal] || DEFAULT_FITNESS_GOAL
      end

      def next_generation(individuals)
        @steps.each do |step|
          individuals = send(step, individuals)
        end
        individuals
      end

      private

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
