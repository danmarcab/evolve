module Evolve
  module Evolution
    class Strategy
      attr_reader :species

      DEFAULT_STEPS = [:selection, :reproduction, :mutation]

      def initialize(options={})
        @steps = options[:evolution_steps] || DEFAULT_STEPS
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
