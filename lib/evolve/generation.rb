module Evolve
  class Generation
    attr_reader :species, :size, :individuals

    DETAULT_GENERATION_SIZE = 10

    def initialize(species, options={})
      @species = species
      @size = options[:size] || DETAULT_GENERATION_SIZE
      @individuals = @size.times.map { @species.new }
    end

    def next_generation!
      @individuals = @individuals.shuffle
    end
  end
end
