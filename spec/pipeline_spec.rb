require_relative 'lib/spec_helper'

describe "return json" do

  it "should return a json representation of a pipeline" do

    pipeline = Pipeline.new 'test'
    pipeline.stages << Stage.new('a')
    pipeline.stages << Stage.new('b')
    pipeline.stages << Stage.new('c')

    pipeline.to_json.should == "{\"name\":\"test\",\"stages\":[{\"name\":\"a\"},{\"name\":\"b\"},{\"name\":\"c\"}]}"
  end

  it "should parse back to ruby hash from json and still match" do

    pipeline = Pipeline.new 'test'
    pipeline.stages << Stage.new('a')
    pipeline.stages << Stage.new('b')
    pipeline.stages << Stage.new('c')

    hash_pipeline = JSON.parse(pipeline.to_json)
    hash_pipeline.should == {"name"=>"test","stages"=>[{"name"=>"a"},{"name"=>"b"},{"name"=>"c"}]}
  end
end