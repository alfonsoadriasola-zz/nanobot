require 'minitest/autorun'
load 'nano2.rb'

class TestNano < Minitest::Test
  def test_this_shit
    input_layer = Array.new(2)
    hidden_layer = Array.new(8)
    output_layer = Array.new(2)

    nano = NeuralNetwork.new(
            input_layer: input_layer,
            hidden_layer: hidden_layer,
            output_layer: output_layer
            )
    assert nano
    assert nano.instance_variable_get('@weights1').size > 1 
  end
end
