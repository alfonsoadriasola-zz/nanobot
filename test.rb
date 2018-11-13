require 'awesome_print'
require 'minitest/autorun'
load 'nano2.rb'

describe NeuralNetwork do
  describe "basics" do
    def setup
      input_layer = Array.new(2)
      hidden_layer = Array.new(8)
      output_layer = Array.new(2)

      @nano = NeuralNetwork.new(
        input_layer: input_layer,
        hidden_layer: hidden_layer,
        output_layer: output_layer)
    end

    it "works ok?" do
      @nano.wont_be_nil
    end

    it "can have weights" do
      assert @nano.instance_variable_get('@weights1').size > 1
    end

    it "should have weights" do
      assert @nano.instance_variable_get('@weights2').size > 1
    end
  end

  describe "more" do
    it "can do more than nothing‰" do
      input_layer = Array.new(2, 12)
      hidden_layer = Array.new(8)
      output_layer = Array.new(2, 0)

      @nano = NeuralNetwork.new( input_layer: input_layer,
        hidden_layer: hidden_layer,
        output_layer: output_layer)
      @nano.feedforward
    end

    it "adds up" do
      input_layer = [0.05,0.1]
      hidden_layer = Array.new(2)
      output_layer = Array.new(2)
      nano = NeuralNetwork.new(
        input_layer: input_layer,
        hidden_layer: hidden_layer,
        output_layer: output_layer
      )
      nano.bias1 = 0.35
      nano.bias2 = 0.60
      nano.weights1 = [0.15, 0.20, 0.25, 0.30]
      nano.weights2 = [0.45, 0.50, 0.55, 0.55]

      nano.calc_hidden( nano.input, nano.weights1 , nano.bias1 ).must_equal 0.3775
      
    end
  end
end