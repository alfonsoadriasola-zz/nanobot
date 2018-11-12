require 'minitest/autorun'
load 'nano2.rb'

describe NeuralNetwork do
  def setup
    input_layer = Array.new(2)
    hidden_layer = Array.new(8)
    output_layer = Array.new(2)

    @nano = NeuralNetwork.new(
      input_layer: input_layer,
      hidden_layer: hidden_layer,
      output_layer: output_layer
      )
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
