require_relative 'lib/spec_helper'

describe "Radiator to JSON" do

  it "should return a json representation of a radiator" do

    pipeline1 = Pipeline.new 'pipeline1'
    stage1 = Stage.new '1'
    stage2 = Stage.new '2'
    pipeline1.stages << stage1
    pipeline1.stages << stage2

    pipeline2 = Pipeline.new 'pipeline2'
    stage3 = Stage.new '3'
    stage4 = Stage.new '4'
    pipeline2.stages << stage3
    pipeline2.stages << stage4

    radiator = Radiator.new
    radiator.pipelines << pipeline1
    radiator.pipelines << pipeline2

    radiator.to_json.should == "{\"pipelines\":[{\"name\":\"pipeline1\",\"stages\":[{\"name\":\"1\"},{\"name\":\"2\"}]},{\"name\":\"pipeline2\",\"stages\":[{\"name\":\"3\"},{\"name\":\"4\"}]}]}"
  end
end