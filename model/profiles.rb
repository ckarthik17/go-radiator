require_relative 'JSONable'

class Profiles
  include JSONable

  attr_accessor :profiles

  def initialize
    @profiles = []
  end

end


class Profile
  include JSONable

  def initialize(name, pipelines)
    @name = name
    @pipelines = pipelines
  end
end