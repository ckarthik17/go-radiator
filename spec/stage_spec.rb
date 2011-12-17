require_relative 'lib/spec_helper'

describe "To Json" do

  it "should return a json representation of a stage" do

    stage = Stage.new "test"

    stage.to_json.should ==  "{\"name\":\"test\"}"
  end

  it "should parse back to ruby object from json and still match" do

    stage = Stage.new "test_a"

    parsed_stage = JSON.parse(stage.to_json)
    parsed_stage['name'].should == "test_a"
  end

end