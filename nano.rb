require 'pry'
class Brains
  attr_accessor :cortex, :generation
  def initialize(shape = { input: 738, hidden1: 16, hidden2: 16, output: 10 })
    @generation = 0
    @cortex = {}
    prev = nil
    shape.each do |key, size|
      arr = Array.new(size, Neuron.new(prev))
      @cortex[key] = arr
      prev = key
    end
  end

  def input(array)
    @generation += 1
    @cortex[:input].each_with_index do |neuron, i|
      neuron.activation = array[i]
    end
    @cortex[:hidden1].each{|neuron| neuron.fire(@cortex)}
    @cortex[:hidden2].each{|neuron| neuron.fire(@cortex)}
    @cortex[:output].each{|neuron| neuron.fire(@cortex)}
  end

  def output(); end
end

class Neuron
  attr_accessor :activation, :bias, :connect_back_to
  def initialize(back_to)
    @activation = 0.00
    @bias = -1
    @connect_back_to = back_to
  end

  def connections(cortex)
    cortex[connect_back_to]
  end

  def fire(cortex)
    sum = connections(cortex).reduce(activation) { |m, v| m + v.activation.to_f }
    sum += bias
    @activation = 1.0 / (1.0 + Math.exp(- sum))
  end
end

# # # TESTS
class BrainTest
  def self.test
    @brains = Brains.new
    @brains.input []

    sample = Array.new(738, 1)
    @brains.input(sample)

    sample = Array.new(738, 0)
    @brains.input(sample)

    pp @brains.generation
    pp @brains
  end
end

BrainTest.test
