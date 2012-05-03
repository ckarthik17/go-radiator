class Stage
  attr_reader :name, :last_build_date_time
  attr_accessor :status

  def initialize name, status, last_build_date_time
    @name = name
    @status = status
    @last_build_date_time = last_build_date_time
  end

end