require 'spec_helper'

describe Evolve::Species do
  before do
    described_class.instance_variable_set(:@genes, nil)
  end

  describe ".gene" do
    it "adds a gene to the gene list" do
      expect{
        described_class.gene(:gene)
      }.to change { described_class.genes.count }.by(1)
    end

    it "adds a gene with the name provided" do
      described_class.gene(:gene)
      expect(described_class.genes.keys).to contain_exactly(:gene)
    end

    it "adds an instance of Evolve::Gene" do
      described_class.gene(:gene)
      expect(described_class.genes[:gene]).to be_a(Evolve::Gene)
    end

    context "when a gene providing a class" do
      before do
        @gene_class = Class.new(Evolve::Gene)
      end
      it "adds an instance of the class provided" do
        described_class.gene(:gene, class: @gene_class)
        expect(described_class.genes[:gene]).to be_a(@gene_class)
      end
    end

    context "when adding two genes with the same name" do
      it "raises a name error" do
        expect{
          described_class.gene(:gene)
          described_class.gene(:gene)
        }.to raise_error(NameError, "Gene name 'gene' already in use")
      end
    end
  end

  describe "#new" do
    describe "#fitness" do
      context "when the Species does not have a evaluate_fitness method defined" do
        it "returns the default fitness value" do
          expect(described_class.new.fitness).to eq(described_class::DEFAULT_FITNESS)
        end
      end

      context "when the Species have a evaluate_fitness method defined" do
        before do
          @species = Class.new(described_class)
          @species.class_eval do
            define_method(:evaluate_fitness) { 100 }
          end
        end

        it "returns the value calculated by the method provided" do
          expect(@species.new.fitness).to eq(100)
        end
      end

    end

    describe "#genes" do
      context "when the Species have a list of genes" do
        before do
          described_class.gene(:gene1, values: [1])
          described_class.gene(:gene2, values: [2])
          described_class.gene(:gene3, values: [3])
        end

        subject { described_class.new.genes }

        it "is a hash" do
          expect(subject).to be_a Hash
        end

        it "has the name of the genes as keys" do
          expect(subject.keys).to contain_exactly(:gene1, :gene2, :gene3)
        end

        it "has the values of the genes as the hash values" do
          expect(subject.values).to contain_exactly(1, 2, 3)
        end

        context "when passing genes explicitly" do
          subject { described_class.new(gene2: 100).genes }

          it "overrides the genes provided" do
            expect(subject[:gene2]).to eq(100)
          end

          it "does not override the genes not provided" do
            expect(subject[:gene1]).to eq(1)
            expect(subject[:gene3]).to eq(3)
          end

        end
      end
    end
  end

end
