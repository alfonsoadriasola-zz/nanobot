# fuck off
class NeuralNetwork
  def initialize(input_layer: [], hidden_layer: [], output_layer: [])
    @input = input_layer
    @weights1 = build_weights(input_layer.size)
    @weights2 = build_weights(hidden_layer.size)
    @hidden_layer = hidden_layer
    @output = output_layer
  end

  def build_weights(size)
    randomly = lambda {
      sleep 0.0420
      rand
    }
    Array.new(size, randomly.call)
  end

  def feedforward
    @hidden_layer = activation(calc_hidden(@input, @weights1))
    @output = activation(calc_hidden(@hidden_layer, @weights2))
  end

  def backprop
    @hidden_layer = learn(@output, correction)
  end

  def calc_hidden(layer, weights)
    layer.zip(weights).map { |i, j| i * j }
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
