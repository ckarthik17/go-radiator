require_relative 'radiator'
require_relative 'raw_data'

class XmlToRadiatorTransformer

  def transform xml
    raw_data_rows = extract_raw_data xml
    raw_data_to_radiator_transform raw_data_rows
  end

  def extract_raw_data xml
    rows = xml.xpath("//Project")

    raw_data_rows = []
    rows.each do |row|
      raw_data = RawData.new
      raw_data.activity = row['activity'].downcase!
      raw_data.last_build_status = row['lastBuildStatus'].downcase!
      raw_data.last_build_label = row['lastBuildLabel'].split()[0]
      raw_data.last_build_date = row['lastBuildTime'].split('T')[0]
      raw_data.last_build_time = row['lastBuildTime'].split('T')[1]

      names = row['name'].split()
      raw_data.pipeline_name = names[0]
      raw_data.stage_name = names[2]
      raw_data_rows << raw_data
    end

    raw_data_rows
  end

  def raw_data_to_radiator_transform raw_data_rows
    radiator = Radiator.new

    puts raw_data_rows.count
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
        pipeline = Pipeline.new(pipeline_name, row.last_build_label, row.last_build_date, row.last_build_time)
        pipeline.stages << Stage.new(stage_name, status)
        radiator.pipelines << pipeline

        previous_name = pipeline_name
        previous_stage_name = stage_name
        previous_pipeline = pipeline
      elsif stage_name != previous_stage_name
        previous_pipeline.stages << Stage.new(stage_name, status)
        previous_stage_name = stage_name
      end
    end

    radiator
  end

end