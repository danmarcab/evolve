module Evolve
  class Species
    class << self
      def genes
        @genes ||= {}
      end

      def gene(name, options={})
        raise NameError.new("Gene name '#{name}' already in use") if genes.has_key?(name)

        gene_class = options[:class] || Evolve::Gene
        genes[name] = gene_class.new(name, options)
      end

      def population
        @population
      end

      def strategy
        config.strategy
      end

      def runner
        config.runner
      end

      def config
        @config ||= Evolve::Evolution::Configuration.new
      end

      def evolve_with(options = {}, &block)
        @config = Evolve::Evolution::Configuration.new(options, &block)
      end

      def evolve!
        born!
        runner.evolve(self)
      end

      def born!
        @population = Evolve::Population.new(self, config.population_options)
      end

      def next_generation!
        @population.next_generation!(strategy)
      end
    end

    attr_reader :genes, :fitness

    DEFAULT_FITNESS = 0

    def initialize(explicit_genes = {})
      @genes = species_genes.each_with_object({}) do |(name, gene), genes|
        genes[name] = explicit_genes[name] ||  gene.sample
      end
      @fitness = evaluate_fitness
    end

    protected

    def evaluate_fitness
      DEFAULT_FITNESS
    end

    def species_genes
      self.class.genes
    end
  end
end
