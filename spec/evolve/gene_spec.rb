require 'spec_helper'

describe Evolve::Gene do

  describe "#sample" do
    context "when initialized with no options" do
      before do
        @gene = described_class.new(:gene)
      end

      it "returns nil" do
        expect(@gene.sample).to be_nil
      end
    end

    context "when initialized with an array of possible values" do
      before do
        @values = [1,2,3]
        @gene = described_class.new(:gene, values: @values)
      end

      it "returns one of the values" do
        expect(@values).to include(@gene.sample)
      end
    end

    context "when initialized with a range of possible values" do
      before do
        @range = 1..10
        @gene = described_class.new(:gene, range: @range)
      end

      it "returns one of the values" do
        expect(@range).to cover(@gene.sample)
      end
    end

  end
end
