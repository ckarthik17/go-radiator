require_relative 'xml_to_radiator_transformer'

class Retriever

  def get_data
    get_xml_test
  end

  def get_pipeline_data name
    get_xml_test.pipelines.each do |pipeline|
       return pipeline if pipeline.name.downcase == name.downcase
    end
    Pipeline.new "Pipeline Not Found", "N/A", "N/A", "N/A"
  end

  private
  def get_xml_test
    puts File.dirname(__FILE__) + '/sample_data.xml'
    file = File.open(File.dirname(__FILE__) + '/sample_data.xml')
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