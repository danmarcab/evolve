require 'spec_helper'

describe Evolve::Evolution::Runner do

  describe "#new" do
    context "when initialized with no options" do
      before do
        @runner = described_class.new
      end

      it "sets max generations to the default" do
        expect(@runner.max_generations).to eq(described_class::DEFAULT_MAX_GENERATIONS)
      end
    end

    context "when initialized with max generations option" do
      before do
        @runner = described_class.new(max_generations: 200)
      end

      it "sets max generations to the value provided" do
        expect(@runner.max_generations).to eq(200)
      end
    end

    context "fitness goal" do
      context "with numeric fitness goal" do
        before do
          @runner = described_class.new(fitness_goal: 200)
        end

        it "sets fitness goal to the value provided" do
          expect(@runner.fitness_goal).to eq(200)
        end

        it "sets fitness delta to the default value" do
          expect(@runner.fitness_delta).to eq(described_class::DEFAULT_FITNESS_DELTA)
        end
      end

      context "with numeric fitness goal and delta provided" do
        before do
          @runner = described_class.new(fitness_goal: 200, fitness_delta: 0.1)
        end

        it "sets fitness goal to the value provided" do
          expect(@runner.fitness_goal).to eq(200)
        end

        it "sets fitness delta to the default value" do
          expect(@runner.fitness_delta).to eq(0.1)
        end
      end

      context "with no numeric fitness goal" do
        before do
          @runner = described_class.new(fitness_goal: :bigger_better)
        end

        it "does not set fitness goal" do
          expect(@runner.fitness_goal).to be_nil
        end

        it "does not set fitness delta" do
          expect(@runner.fitness_delta).to be_nil
        end
      end
    end
  end

  describe "#evolve" do
    before do
      @species = Evolve::Species
      @runner = described_class.new
      allow(@runner).to receive(:evolution_finished?).and_return(false, false, true)
    end

    it "calls next_generation on the species until the evolution finish" do
      expect(@species).to receive(:next_generation!).twice
      @runner.evolve(@species)
    end
  end

  describe "#evolution_finished" do
    before do
      @best_individual = Evolve::Species.new
      @population = double
      allow(@population).to receive(:best_individual).and_return(@best_individual)
    end

    context "max generation" do
      before do
        @runner = described_class.new(max_generations: 200)
      end

      context "when population generation has not reached the limit" do
        before do
          allow(@population).to receive(:generation).and_return(100)
        end

        it "returns false" do
          expect(@runner.evolution_finished?(@population)).to be_falsey
        end
      end

      context "when population generation has reached the limit" do
        before do
          allow(@population).to receive(:generation).and_return(200)
        end

        it "returns true" do
          expect(@runner.evolution_finished?(@population)).to be_truthy
        end
      end
    end

    context "fitness goal" do
      before do
        @runner = described_class.new(fitness_goal: 200, fitness_delta: 0.1)
        allow(@population).to receive(:generation).and_return(1)
      end

      context "when best individual fitness has not reached the goal" do
        before do
          allow(@best_individual).to receive(:fitness).and_return(100)
        end

        it "returns false" do
          expect(@runner.evolution_finished?(@population)).to be_falsey
        end
      end

      context "when best individual fitness has reached the goal" do
        before do
          allow(@best_individual).to receive(:fitness).and_return(200)
        end

        it "returns true" do
          expect(@runner.evolution_finished?(@population)).to be_truthy
        end
      end

      context "when best individual fitness has reached the goal within the delta" do
        before do
          allow(@best_individual).to receive(:fitness).and_return(199.91)
        end

        it "returns true" do
          expect(@runner.evolution_finished?(@population)).to be_truthy
        end
      end
    end
  end
end
