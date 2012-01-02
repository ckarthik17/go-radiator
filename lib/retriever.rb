require_relative 'model/xml_to_radiator_transformer'

class Retriever

  def get_data
    get_xml_test
  end

  private
  def get_xml_test
    puts
    file = File.open(File.dirname(__FILE__) + '/sample_data.xml')
    xml_doc = Nokogiri::XML(file)
    file.close

    XmlToRadiatorTransformer.new.transform xml_doc
  end

  def get_cctray_response url, domain, user, password
    http_client = HTTPClient.new
    http_client.set_auth(domain, user, password)

    http_client.get(url)
  end

end