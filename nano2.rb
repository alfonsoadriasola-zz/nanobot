# fuck off
require 'securerandom'
class NeuralNetwork
  attr_accessor :input, :output, :weights1, :weights2, :bias1, :bias2, :hidden_layer
  def initialize(input_layer: [], hidden_layer: [], output_layer: [])
    @input = input_layer
    @weights1 = build_weights(input_layer.size)
    @bias1 = randomly.call
    @weights2 = build_weights(hidden_layer.size)
    @bias2 = randomly.call
    @hidden_layer = hidden_layer
    @output = output_layer
  end

  def randomly
    -> { SecureRandom.random_number }
  end

  def build_weights(size)
    Array.new(size).map{ randomly.call }
  end

  def feedforward
    out = calc_hidden(@input, @weights1, @bias1)
    hidden_layer[0] = sigmoid(out)
  end

  def backprop
    @hidden_layer = learn(@output, correction)
  end

  def calc_hidden(layer, weights, bias)
    layer.zip(weights).map { |i, j| i * j}.sum + (1*bias)
  end

  def activation(layer)
    layer.map { |e| sigmoid(e) }
  end

  def sigmoid(val)
    1.0 / (1.0 + Math.exp(- val))
  end

  def sigmoid_prime(val)
    val * (1 - val)
  end

  def learn(layer)
    layer.map { |e| sigmoid_prime(e) }
  end
end
