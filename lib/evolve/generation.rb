module Evolve
  class Generation
    attr_reader :species, :size, :individuals
    attr_accessor :number

    DETAULT_GENERATION_SIZE = 10

    def initialize(species, options={})
      @species = species
      @size = options[:size] || DETAULT_GENERATION_SIZE
      @individuals = @size.times.map { @species.new }
      @number = 1
    end

    def best_individual
      @individuals.sort{ |individual| individual.fitness}.last
    end
  end
end
