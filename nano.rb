require 'pry'
class Brains
  attr_accessor :cortex, :generation
  def initialize(shape = { input: 738, hidden1: 16, hidden2: 16, output: 10 })
    @generation = 0
    @cortex = {}
    shape.each do |key, size|
      arr = Array.new(size).map { Neuron.new }
      @cortex[key] = arr
    end
  end

  def fire
    @cortex[:hidden1].each(&:fire)
  end

  def input(array)
    @generation += 1
    @cortex[:input].each_with_index do |neuron, i|
      neuron.activation = array[i]
    end
  end

  def output(); end
end

class Neuron
  attr_accessor :activation, :connections
  def initialize
    @activation = 0.00
    @connections = []
  end

  def fire
    sum = connections.reduce(activation) { |m, v| m + v }
    @activation = 1.0 / (1.0 + Math.exp(- sum))
  end
end

# # # TESTS
class BrainTest
  def self.test
    @brains = Brains.new
    @brains.fire
    sample= Array.new(738,1)
    @brains.input(sample)
    @brains.fire
    pp @brains
  end
end

BrainTest.test
