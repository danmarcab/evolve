module Evolve
  class Population
    attr_reader :species, :size, :individuals
    attr_accessor :generation

    DETAULT_POPULATION_SIZE = 10

    def initialize(species, options={})
      @species = species
      @size = options[:size] || DETAULT_POPULATION_SIZE
      @individuals = @size.times.map { @species.new }
      @generation = 1
    end

    def best_individual
      @individuals.sort{ |individual| individual.fitness}.last
    end
  end
end
