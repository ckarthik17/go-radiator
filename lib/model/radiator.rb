require_relative 'JSONable'

class Radiator < JSONable
  attr_accessor :pipelines

  def initialize
    @pipelines = []
  end
end

class Pipeline
  attr_reader :name
  attr_accessor :stages

  def initialize name
    @name = name
    @stages = []
  end

end

class Stage
  attr_reader :name, :status

  def initialize name, status
    @name = name
    @status = status
  end
end