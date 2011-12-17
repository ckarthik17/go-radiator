require_relative 'lib/spec_helper'

describe "Get CCTray xml" do

  it "should get CCTray xml from GO" do

    response = Retriever.new.get_cctray_response 'http://vl2gos002:8153/go/cctray.xml', 'http://vl2gos002:8153', 'SVCGO3', 'GjUvm96t'
    response.status.should == 200
    xml_doc = Nokogiri::XML(response.body)
    xml_doc.xpath().should


    puts response.body
  end
end