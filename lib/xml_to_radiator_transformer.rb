require "rubygems"
require "bundler/setup"

require 'nokogiri'

require_relative 'model/radiator'
require_relative 'model/raw_data'

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
      raw_data.activity = row['activity']
      raw_data.last_build_label = row['lastBuildLabel']
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

      if pipeline_name != previous_name
        pipeline = Pipeline.new(pipeline_name)
        pipeline.stages << Stage.new(stage_name)
        radiator.pipelines << pipeline

        previous_name = pipeline_name
        previous_stage_name = stage_name
        previous_pipeline = pipeline
      else
        if stage_name != previous_stage_name
          previous_pipeline.stages << Stage.new(stage_name)
          previous_stage_name = stage_name
        end
      end
    end

    radiator
  end

end