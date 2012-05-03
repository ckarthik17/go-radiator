require_relative 'stage'
require_relative 'pipeline'
require_relative 'radiator'
require_relative 'raw_data'
require 'date'

class XmlToRadiatorTransformer

  def transform xml
    raw_data_rows = extract_raw_data xml
    radiator = raw_data_to_radiator_transform raw_data_rows
    cleanse_data radiator
  end

  private
  def extract_raw_data xml
    rows = xml.xpath("//Project")

    raw_data_rows = []
    rows.each do |row|
      raw_data = RawData.new
      raw_data.activity = row['activity'].downcase!
      raw_data.last_build_status = row['lastBuildStatus'].downcase!
      raw_data.last_build_label = row['lastBuildLabel'].split()[0]
      raw_data.last_build_date_time = row['lastBuildTime']

      names = row['name'].split()
      raw_data.pipeline_name = names[0]
      raw_data.stage_name = names[2]
      raw_data_rows << raw_data
    end

    raw_data_rows
  end

  def raw_data_to_radiator_transform raw_data_rows
    radiator = Radiator.new
    previous_name = ""
    previous_stage_name = ""
    previous_pipeline = nil
    raw_data_rows.each do |row|

      pipeline_name = row.pipeline_name
      stage_name = row.stage_name
      status = row.activity

      if row.activity == "sleeping"
        status = row.last_build_status
      end

      if pipeline_name != previous_name
        pipeline = Pipeline.new(pipeline_name, row.last_build_label, row.last_build_date_time)
        pipeline.stages << Stage.new(stage_name, status, row.last_build_date_time)
        radiator.pipelines << pipeline
        previous_name = pipeline_name
        previous_stage_name = stage_name
        previous_pipeline = pipeline
      elsif stage_name != previous_stage_name
        previous_pipeline.stages << Stage.new(stage_name, status, row.last_build_date_time)
        previous_stage_name = stage_name
      end
    end

    radiator
  end

  def cleanse_data(dirty_radiator)
    clean_radiator = dirty_radiator

    clean_radiator.pipelines.each do |pipeline|
      cleanse_pipeline(pipeline)
    end

    clean_radiator.pipelines.each do |pipeline|
        pipeline.set_current_stage
    end

    clean_radiator
  end

  def cleanse_pipeline(pipeline)
    previous_status = ''
    previous_success_date = nil
    pipeline.stages.each do |stage|

      if previous_status == 'building' || previous_status == 'failure' || previous_status == 'clear'
        stage.status = 'clear'
      end

      if previous_status != 'building' || previous_status != 'failure' || previous_status != 'clear'
        previous_status = stage.status
      end

      if previous_status == 'success'
        if previous_success_date == nil
          previous_success_date = DateTime.parse(stage.last_build_date_time)
        end
        if previous_success_date > DateTime.parse(stage.last_build_date_time)
          stage.status = 'clear'
        end
      end
    end
  end

end