require_relative 'JSONable'

class Radiator
  include JSONable

  attr_accessor :pipelines

  def initialize
    @pipelines = []
  end

  def get_pipeline name
    @pipelines.each { |p| return p if p.name.downcase == name.downcase }
    Pipeline.new "Pipeline Not Found", "N/A", "N/A"
  end
end
