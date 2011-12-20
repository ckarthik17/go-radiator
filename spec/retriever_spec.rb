require_relative 'lib/spec_helper'

describe "Get CCTray xml" do

  it "should get CCTray xml from GO" do

    response = Retriever.new.get_cctray_response 'cctray_link', 'domain', 'user', 'password'
    response.status.should == 200
    xml_doc = Nokogiri::XML(response.body)
    xml_doc.xpath().should


    puts response.body
  end
end