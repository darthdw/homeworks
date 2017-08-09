require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef") }
  let(:pie) { Dessert.new("pie", 20, chef) }

  describe "#initialize" do
    it "sets a type" do
      expect(pie.type).to eq("pie")
    end
    it "sets a quantity" do
      expect(pie.quantity).to eq(20)
    end

    it "starts ingredients as an empty array" do
      expect(pie.ingredients).to match_array([])
    end

    it "raises an argument error when given a non-integer quantity" do
      expect(Dessert.new("pie","a while lot!",chef) ).to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      pie.add_ingredient("chocolate")
      expect(pie.ingredients).to include('chocolate')
    end
  end

  # Pulled from solutions. How exactly does this work and why does it look so
  # differnet from the example I was trying to use?

  describe "#mix!" do
    it "shuffles the ingredients array!" do
    ingredients = ["chocolate", "flour", "egg", "sugar", "butter"]
      ingredients.each do |ingredient|
        pie.add_ingredient(ingredient)
      end

      expect(pie.ingredients).to eq(ingredients)
      pie.mix!
      expect(pie.ingredients).not_to eq(ingredients)
      expect(pie.ingredients.sort).to eq(ingredients.sort)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      pie.eat(5)
      expect(pie.quantity).to eq(15)
    end

    it "raises an error if the amount is greater than the quantity" do
      pie.eat(25)
      expect(pie.quantity).to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      # Taken from solutions again. Look at the 'receive' func.
      allow(chef).to receive(:titleize).and_return("Chef Tucker the Great Baker")
      expect(pie.serve).to eq("Chef Tucker the Great Baker has made 20 pies!")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(pie)
    pie.make_more
     end
    end
  end
