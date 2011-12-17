require_relative 'JSONable'

class Pipeline < JSONable
  attr_reader :name
  attr_accessor :stages

  def initialize name
    @name = name
    @stages = []
  end

end

class Stage < JSONable
  attr_reader :name

  def initialize name
    @name = name
  end
end