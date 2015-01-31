require 'spec_helper'

describe Evolve::Generation do
  before do
    @species = Evolve::Species
  end

  describe "#new" do
    before do
      @generation = described_class.new(@species)
    end

    it "sets the species" do
      expect(@generation.species).to eq(@species)
    end

    it "sets the size to the default" do
      expect(@generation.size).to eq(described_class::DETAULT_GENERATION_SIZE)
    end

    it "creates an array of individuals" do
      expect(@generation.individuals).to be_a Array
    end

    it "individuals have the size of the generation" do
      expect(@generation.individuals.size).to eq(@generation.size)
    end

    it "every induvidual is one member of the species" do
      expect(@generation.individuals).to all(be_a @species)
    end

    context "when a size provided in options" do
      before do
        @generation = described_class.new(@species, size: 20)
      end

      it "sets the size to the size provided" do
        expect(@generation.size).to eq(20)
      end
    end
  end
end
