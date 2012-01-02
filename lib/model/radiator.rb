require_relative '../model/JSONable'

class Radiator
  include JSONable

  attr_accessor :pipelines

  def initialize
    @pipelines = []
  end
end

class Pipeline
  attr_reader :name, :build_label, :last_build_date, :last_build_time
  attr_accessor :stages

  def initialize name, build_label, last_build_date, last_build_time
    @name = name
    @build_label = build_label
    @last_build_date = last_build_date
    @last_build_time = last_build_time
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