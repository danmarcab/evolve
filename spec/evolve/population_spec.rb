require 'spec_helper'

describe Evolve::Population do
  before do
    @species = Evolve::Species
  end

  describe "#new" do
    before do
      @population = described_class.new(@species)
    end

    it "sets the species" do
      expect(@population.species).to eq(@species)
    end

    it "sets the size to the default" do
      expect(@population.size).to eq(described_class::DETAULT_POPULATION_SIZE)
    end

    it "creates an array of individuals" do
      expect(@population.individuals).to be_a Array
    end

    it "individuals have the size of the population" do
      expect(@population.individuals.size).to eq(@population.size)
    end

    it "every induvidual is one member of the species" do
      expect(@population.individuals).to all(be_a @species)
    end

    context "when a size provided in options" do
      before do
        @population = described_class.new(@species, size: 20)
      end

      it "sets the size to the size provided" do
        expect(@population.size).to eq(20)
      end
    end
  end
end
