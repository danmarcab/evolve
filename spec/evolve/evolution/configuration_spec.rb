require 'spec_helper'

describe Evolve::Evolution::Configuration do

  describe "#new" do
    before do
      @strategy_options = Hash[described_class::STRATEGY_OPTIONS.zip(described_class::STRATEGY_OPTIONS)]
      @runner_options = Hash[described_class::RUNNER_OPTIONS.zip(described_class::RUNNER_OPTIONS)]
      @population_options = Hash[described_class::POPULATION_OPTIONS.zip(described_class::POPULATION_OPTIONS)]
      @all_options = @strategy_options.merge(@runner_options).merge(@population_options)
    end

    context "when initialized with no options and no block" do
      before do
        @config = described_class.new
      end

      it "has an empty hash for strategy options" do
        expect(@config.strategy_options).to eq({})
      end

      it "has an empty hash for runner options" do
        expect(@config.runner_options).to eq({})
      end

      it "has an empty hash for population options" do
        expect(@config.population_options).to eq({})
      end
    end

    context "when initialized with block" do
      before do
        @config = described_class.new do |config|
          @all_options.each do |option, value|
            config.send("#{option}=", value)
          end
        end
      end

      it "has a hash containing the provided strategy options" do
        expect(@config.strategy_options).to eq(@strategy_options)
      end

      it "has a hash containing the provided runner options" do
        expect(@config.runner_options).to eq(@runner_options)
      end

      it "has a hash containing the provided population options" do
        expect(@config.population_options).to eq(@population_options)
      end
    end

    context "when initialized with options hash" do
      before do
        @config = described_class.new(@all_options)
      end

      it "has a hash containing the provided strategy options" do
        expect(@config.strategy_options).to eq(@strategy_options)
      end

      it "has a hash containing the provided runner options" do
        expect(@config.runner_options).to eq(@runner_options)
      end

      it "has a hash containing the provided population options" do
        expect(@config.population_options).to eq(@population_options)
      end
    end
  end

  describe "#strategy" do
    context "when strategy is set" do
      before do
        @strategy = double
        @config = described_class.new(strategy: @strategy)
      end

      it "returns the strategy set" do
        expect(@config.strategy).to eq(@strategy)
      end
    end

    context "when strategy is not set" do
      before do
        @strategy = double
        @strategy_options = {option1: 2}
        @config = described_class.new

        allow(Evolve::Evolution::Strategy).to receive(:new).and_return(@strategy)
        allow(@config).to receive(:strategy_options).and_return(@strategy_options)
      end

      it "creates a strategy with the strategy options and returns it" do
        expect(Evolve::Evolution::Strategy).to receive(:new).with(@strategy_options)
        expect(@config.strategy).to eq(@strategy)
      end
    end
  end

  describe "#runner" do
    context "when runner is set" do
      before do
        @runner = double
        @config = described_class.new(runner: @runner)
      end

      it "returns the runner set" do
        expect(@config.runner).to eq(@runner)
      end
    end

    context "when runner is not set" do
      before do
        @runner = double
        @runner_options = {option1: 2}
        @config = described_class.new

        allow(Evolve::Evolution::Runner).to receive(:new).and_return(@runner)
        allow(@config).to receive(:runner_options).and_return(@runner_options)
      end

      it "creates a runner with the runner options and returns it" do
        expect(Evolve::Evolution::Runner).to receive(:new).with(@runner_options)
        expect(@config.runner).to eq(@runner)
      end
    end
  end
end
