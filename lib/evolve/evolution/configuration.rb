module Evolve
  module Evolution
    class Configuration
      attr_accessor :strategy, :runner, :population_options

      STRATEGY_OPTIONS = [:evolution_steps, :fitness_goal]
      RUNNER_OPTIONS = [:fitness_goal, :fitness_delta, :max_generations]
      POPULATION_OPTIONS = [:initial_population_size]

      attr_accessor *STRATEGY_OPTIONS
      attr_accessor *RUNNER_OPTIONS
      attr_accessor *POPULATION_OPTIONS

      def initialize(options={}, &block)
        assign_options(options)
        block.call(self) if block_given?
      end

      def strategy
        @strategy ||= Evolve::Evolution::Strategy.new(strategy_options)
      end

      def runner
        @runner ||= Evolve::Evolution::Runner.new(runner_options)
      end

      def strategy_options
        @strategy_options ||= get_options(STRATEGY_OPTIONS)
      end

      def runner_options
        @runner_options ||= get_options(RUNNER_OPTIONS)
      end

      def population_options
        @population_options || get_options(POPULATION_OPTIONS)
      end

      private

      def get_options(option_keys)
        option_keys.each_with_object({}) do |option, options_hash|
          options_hash[option] = self.send(option)
        end
      end

      def assign_options(options)
        options.each do |option, value|
          self.send("#{option}=", value)
        end
      end
    end
  end
end
