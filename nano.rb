require 'pry'
class Brains
  attr_accessor :cortex, :generation
  def initialize(shape = { input: 784, hidden1: 16, hidden2: 16, output: 10 })
    @generation = 0
    @cortex = {}
    prev = nil
    shape.each do |key, size|
      arr = Array.new(size, Neuron.new(cortex, prev))
      @cortex[key] = arr
      prev = key
    end
  end

  def input(array)
    @generation += 1
    @cortex[:input].each_with_index do |neuron, i|
      neuron.activation = array[i]
    end
    @cortex[:hidden1].each { |neuron| neuron.fire(@cortex) }
    @cortex[:hidden2].each { |neuron| neuron.fire(@cortex) }
    @cortex[:output].each { |neuron| neuron.fire(@cortex) }
  end

  def output
    @cortex[:output].map(&:activation)
  end

  def backprop(desired)
    @cortex[:output].each_with_index do |n, i|
      correction = (desired[i]**2 - n.activation**2)
      n.activation += correction
      n.backprop(@cortex, correction)
    end
  end
end

class Neuron
  attr_accessor :activation, :bias, :connect_back_to, :weights
  def initialize(cortex, back_to)
    @activation = rand
    @bias = -10
    @connect_back_to = back_to
    @weights = cortex[back_to].size.times.map { rand } if back_to
  end

  def connections(cortex)
    arr = []
    cortex[connect_back_to].each_with_index { |n, i| arr << [n.activation, weights[i]] }
    arr
  end

  def fire(cortex)
    sum = connections(cortex).reduce(activation) { |m, v| m + v[0].to_f * v[1].to_f }
    sum += bias
    @activation = 1.0 / (1.0 + Math.exp(- sum))
  end

  def backprop(cortex, correction)
    if connect_back_to
      cortex[connect_back_to].each_with_index do |n, i|
        n.backprop(cortex, correction) && weights[i] += correction
      end
    end
    @activation += correction
  end
end

# # # TESTSi
class BrainTest
  def self.test
  
    piczero = '
      0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
      0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
      0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
      0	0	0	0	0	0	0	0	1	1	1	1	1	1	1	1	0	0	0	0	0	0
      0	0	0	0	0	0	0	0	1	1	0	0	0	0	1	1	0	0	0	0	0	0
      0	0	0	0	0	0	0	0	1	1	0	0	0	0	1	1	0	0	0	0	0	0
      0	0	0	0	0	0	0	0	1	1	0	0	0	0	1	1	0	0	0	0	0	0
      0	0	0	0	0	0	0	0	1	1	0	0	0	0	1	1	0	0	0	0	0	0
      0	0	0	0	0	0	0	0	1	1	0	0	0	0	1	1	0	0	0	0	0	0
      0	0	0	0	0	0	0	0	1	1	0	0	0	0	1	1	0	0	0	0	0	0
      0	0	0	0	0	0	0	0	1	1	0	0	0	0	1	1	0	0	0	0	0	0
      0	0	0	0	0	0	0	0	1	1	0	0	0	0	1	1	0	0	0	0	0	0
      0	0	0	0	0	0	0	0	1	1	0	0	0	0	1	1	0	0	0	0	0	0
      0	0	0	0	0	0	0	0	1	1	0	0	0	0	1	1	0	0	0	0	0	0
      0	0	0	0	0	0	0	0	1	1	1	1	1	1	1	1	0	0	0	0	0	0
      0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
      0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
      0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
      0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
      0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
      0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
      0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
    '.chomp.split('').map(&:to_f)
    @brains = Brains.new(input: piczero.size)
    @brains.input(piczero)

    @brains.input(piczero)
    expected = [1,0,0,0,0,0,0,0,0,0]
    @brains.backprop expected
    puts @brains.output
    puts '--------------'

    @brains.input(piczero)
    @brains.backprop expected

    puts @brains.output
  end
end

BrainTest.test
