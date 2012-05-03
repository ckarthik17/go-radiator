class Pipeline
  attr_reader :name, :build_label, :last_build_date_time, :current_stage, :percentage_complete, :current_stage_index
  attr_accessor :stages

  def initialize name, build_label, last_build_date_time
    @name = name
    @build_label = build_label
    @last_build_date_time = last_build_date_time
    @stages = []
    @current_stage = []
  end

  def set_current_stage
    set_percentage_complete @stages[@stages.count-1]

    @stages.each do |stage|
      if stage.status == 'success'
        @current_stage = []
        @current_stage << stage
      end

      if stage.status == 'building' || stage.status == 'failure'
        @current_stage = []
        @current_stage << stage
        set_percentage_complete stage
        return
      end
    end
  end

  def set_percentage_complete stage
    index = @stages.find_index(stage)+1.0
    @current_stage_index = index.round(0)
    @percentage_complete = (100.0*(index/@stages.count)).round(2)
  end

end


