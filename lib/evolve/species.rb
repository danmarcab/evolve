module Evolve
  class Species
    class << self
      def genes
        @genes ||= {}
      end

      def gene(name, options={})
        raise NameError.new("Gene name '#{name}' already in use") if genes.has_key?(name)

        genes[name] = Evolve::Gene.new(name, options)
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
