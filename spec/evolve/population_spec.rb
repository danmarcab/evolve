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
        @population = described_class.new(@species, initial_population_size: 20)
      end

      it "sets the size to the size provided" do
        expect(@population.size).to eq(20)
      end
    end
  end

  describe "#next_generation!" do
    before do
      @population = described_class.new(@species)
    end

    it "calls the strategy to get the new generation" do
      expect(@species.evolution_strategy).to receive(:next_generation).with(@population.individuals)
      @population.next_generation!
    end

    it "sets the individuals to the next generation" do
      @next_generation = double
      allow(@species.evolution_strategy).to receive(:next_generation).and_return(@next_generation)

      @population.next_generation!
      expect(@population.individuals).to eq(@next_generation)
    end

    it "increments the generation number" do
      expect{
        @population.next_generation!
      }.to change(@population, :generation).by(1)
    end
  end

  describe "#best_individual" do
    before do
      @population = described_class.new(@species)
      @population.individuals.each do |individual|
        allow(individual).to receive(:fitness).and_return(rand)
      end
    end

    it "returns the individual with the higher fitness" do
      max_fitness = @population.individuals.map(&:fitness).max
      best_individual = @population.individuals.find { |ind| ind.fitness == max_fitness }
      expect(@population.best_individual).to eq(best_individual)
    end
  end
end
