module Evolve
  module Evolution
    module Operators
      class Reproduction < Evolve::Evolution::Operators::Base
        def apply(individuals)
          individuals.each_slice(2).map { |pair| reproduce(pair[0], pair[1]) }.flatten
        end

        def reproduce(parent_a, parent_b)
          species = parent_a.class
          child_a = species.new(explicit_genes: parent_a.genes)
          child_b = species.new(explicit_genes: parent_b.genes)

          genes_to_combine = species.genes.keys.shuffle.take(species.genes.size)

          genes_to_combine.each do |name|
            gene = species.genes[name]
            child_a.genes[name], child_b.genes[name] = gene.combine(parent_a.genes[name], parent_b.genes[name])
          end
          # puts "+++++++++++"
          # puts "parent_a #{parent_a.genes}"
          # puts "parent_b #{parent_b.genes}"
          # puts "child_a #{child_a.genes}"
          # puts "child_b #{child_b.genes}"
          # puts "+++++++++++"
          [child_a, child_b]
        end
      end
    end
  end
end
