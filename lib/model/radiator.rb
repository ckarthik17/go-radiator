require_relative 'pipeline'

class Radiator < JSONable
  attr_accessor :pipelines

  def initialize
    @pipelines = []
  end
end