require_relative 'lib/spec_helper'

describe "Radiator to JSON" do

  it "should return a json representation of a radiator" do

    pipeline1 = Pipeline.new 'pipeline1', '2', '2011-11-11', '11:00:00'
    stage1 = Stage.new '1', "Success"
    stage2 = Stage.new '2', "Building"
    pipeline1.stages << stage1
    pipeline1.stages << stage2

    pipeline2 = Pipeline.new 'pipeline2', '2', '2011-11-11', '11:00:00'
    stage3 = Stage.new '3', "Success"
    stage4 = Stage.new '4', "Failure"
    pipeline2.stages << stage3
    pipeline2.stages << stage4

    radiator = Radiator.new
    radiator.pipelines << pipeline1
    radiator.pipelines << pipeline2

    radiator.to_json.should == "{\"pipelines\":[{\"name\":\"pipeline1\",\"stages\":[{\"name\":\"1\",\"status\":\"Success\"},{\"name\":\"2\",\"status\":\"Building\"}]},{\"name\":\"pipeline2\",\"stages\":[{\"name\":\"3\",\"status\":\"Success\"},{\"name\":\"4\",\"status\":\"Failure\"}]}]}"
  end

end