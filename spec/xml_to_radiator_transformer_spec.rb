require_relative 'lib/spec_helper'

describe "Transform Xml to GO Radiator Objects" do

  it "should pull out all pipelines" do
    file = File.open(Dir.pwd + '/spec/test.xml')
    xml_doc = Nokogiri::XML(file)
    file.close

    radiator = XmlToRadiatorTransformer.new.transform xml_doc

    radiator.pipelines.count.should == 3
    radiator.pipelines[0].name.should == "Middleware_CI"
    radiator.pipelines[0].build_label.should == "1.1.361"
    radiator.pipelines[0].last_build_date_time.should == "2011-12-06T11:45:27"
    radiator.pipelines[0].current_stage.first.name.should == "BuildAndPackage"
    radiator.pipelines[1].name.should == "Middleware_Deploy"
    radiator.pipelines[1].build_label.should == "358"
    radiator.pipelines[1].last_build_date_time.should == "2011-12-06T09:10:17"
    radiator.pipelines[1].current_stage.first.name.should == "FunctionalTest"
    radiator.pipelines[2].name.should == "Service1_CI"
    radiator.pipelines[2].build_label.should == "61"
    radiator.pipelines[2].last_build_date_time.should == "2011-12-06T18:28:16"
    radiator.pipelines[2].current_stage.first.name.should == "BuildAndPackage"

    radiator.pipelines[0].stages.count.should == 4
    radiator.pipelines[0].stages[0].name.should == "BuildAndPackage"
    radiator.pipelines[0].stages[0].status.should == "building"
    radiator.pipelines[0].stages[0].last_build_date_time.should == "2011-12-06T11:45:27"
    radiator.pipelines[0].stages[1].name.should == "Deploy"
    radiator.pipelines[0].stages[1].status.should == "clear"
    radiator.pipelines[0].stages[2].name.should == "FunctionalTests_1"
    radiator.pipelines[0].stages[2].status.should == "clear"
    radiator.pipelines[0].stages[3].name.should == "FunctionalTests_2"
    radiator.pipelines[0].stages[3].status.should == "clear"

    radiator.pipelines[1].stages.count.should == 3
    radiator.pipelines[1].stages[0].name.should == "Deploy"
    radiator.pipelines[1].stages[0].status.should == "success"
    radiator.pipelines[1].stages[1].name.should == "FunctionalTest"
    radiator.pipelines[1].stages[1].status.should == "failure"
    radiator.pipelines[1].stages[2].name.should == "PerformanceTest"
    radiator.pipelines[1].stages[2].status.should == "clear"

    radiator.pipelines[2].stages.count.should == 2
    radiator.pipelines[2].stages[0].name.should == "BuildAndPackage"
    radiator.pipelines[2].stages[0].status.should == "success"
    radiator.pipelines[2].stages[1].name.should == "Deploy"
    radiator.pipelines[2].stages[1].status.should == "clear"

  end
end