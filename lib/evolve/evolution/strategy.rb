module Evolve
  module Evolution
    class Strategy

      DEFAULT_STEPS = [:selection, :reproduction, :mutation]
      DEFAULT_OPERATORS = {
        selection: {class: Evolve::Evolution::Operators::Selection},
        reproduction: {class: Evolve::Evolution::Operators::Reproduction},
        mutation: {class: Evolve::Evolution::Operators::Mutation}
      }

      DEFAULT_FITNESS_GOAL = :bigger_better

      def initialize(options={})
        @steps = options[:evolution_steps] || DEFAULT_STEPS
        @fitness_goal = options[:fitness_goal] || DEFAULT_FITNESS_GOAL
        build_operators(options[:operators])
      end

      def next_generation(individuals)
        @steps.each do |step|
          individuals = @operators[step].apply(individuals)
          puts step
          puts individuals.size
        end
        individuals
      end

      private

      def build_operators(options={})
        operator_options = DEFAULT_OPERATORS.merge(options)
        @operators = @steps.each_with_object({}) do |step, operators|
          step_options = (options[step] || {}).merge(fitness_goal: @fitness_goal)
          operators[step] = operator_options[step][:class].new(step_options)
        end
      end
    end
  end
end
