module Evolve
  module Evolution
    class Strategy
      DEFAULT_STEPS = [:selection, :reproduction, :mutation]

      def initialize(options={})
        @steps = options[:steps] || DEFAULT_STEPS
      end

      def step(individuals)
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
