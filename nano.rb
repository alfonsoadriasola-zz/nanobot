require 'pry'

class Brains
  attr_accessor :cortex

  def initialize(topology = { input: 738, p1: 32, p2: 16, output: 10 })
    @cortex = {}
    topology.each do |key, size|
      arr = size.times.map { Neuron.new }
      @cortex[key] = arr
    end
  end
end

class Neuron
  attr_accessor :valence, :connections
  def initialize
    valence = 0.50
    connections = []
  end
end

def test
  @brains = Brains.new

  pp @brains
end

test
