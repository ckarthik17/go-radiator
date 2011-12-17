require_relative 'lib/spec_helper'

describe "Transform Xml to GO Radiator Objects" do

  it "should pull out all pipelines" do
    file = File.open('test.xml')
    xml_doc = Nokogiri::XML(file)
    file.close

    radiator = XmlToRadiatorTransformer.new.transform xml_doc

    radiator.pipelines.count.should == 3
    radiator.pipelines[0].name.should == "Middleware_CI"
    radiator.pipelines[1].name.should == "Middleware_Deploy"
    radiator.pipelines[2].name.should == "Service1_CI"

    radiator.pipelines[0].stages.count.should == 4
    radiator.pipelines[0].stages[0].name.should == "BuildAndPackage"
    radiator.pipelines[0].stages[1].name.should == "Deploy"
    radiator.pipelines[0].stages[2].name.should == "FunctionalTests_1"
    radiator.pipelines[0].stages[3].name.should == "FunctionalTests_2"

    radiator.pipelines[1].stages.count.should == 2
    radiator.pipelines[1].stages[0].name.should == "Deploy"
    radiator.pipelines[1].stages[1].name.should == "Test"

    radiator.pipelines[2].stages.count.should == 2
    radiator.pipelines[2].stages[0].name.should == "BuildAndPackage"
    radiator.pipelines[2].stages[1].name.should == "Deploy"

  end
end