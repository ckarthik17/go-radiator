require 'configatron'
require_relative 'xml_to_radiator_transformer'

class Retriever

  def get_data
    if configatron.test_mode
      get_xml_test configatron.test.file.name
    else
      get_cctray_response configatron.url, configatron.domain, configatron.user, configatron.password
    end
  end

  def get_pipeline_data name
    get_xml_test.pipelines.each do |pipeline|
       return pipeline if pipeline.name.downcase == name.downcase
    end
    Pipeline.new "Pipeline Not Found", "N/A", "N/A"
  end

  private
  def get_xml_test file_name
    file = File.open(File.dirname(__FILE__) + '/' + file_name.to_s)
    xml_doc = Nokogiri::XML(file)
    file.close

    XmlToRadiatorTransformer.new.transform xml_doc
  end

  def get_cctray_response url, domain, user, password
    http_client = HTTPClient.new
    http_client.set_auth(domain, user, password)

    http_client.get(url)

    #TODO: Implement get for CCtray response fully
  end

end