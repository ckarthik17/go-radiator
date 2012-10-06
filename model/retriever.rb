require 'configatron'
require_relative 'xml_to_radiator_transformer'

class Retriever

  def get_data
    if configatron.test.mode == true
      radiator = get_xml_test configatron.test.file.name
    else
      radiator = get_cctray_response configatron.url, configatron.domain, configatron.user, configatron.password
    end
    pipeline_reducer radiator
  end

  def get_pipeline_data name
    get_xml_test.pipelines.each do |pipeline|
       return pipeline if pipeline.name.downcase == name.downcase
    end
    Pipeline.new "Pipeline Not Found", "N/A", "N/A"
  end

  private
  def get_xml_test file_name
    #file = File.open(File.dirname(__FILE__) + '/' + file_name.to_s)
    file = IO.read(File.dirname(__FILE__) + '/' + file_name.to_s);
    xml_doc = Nokogiri::XML(file)
    #file.close

    XmlToRadiatorTransformer.new.transform xml_doc
  end

  def get_cctray_response url, domain, user, password
    http_client = HTTPClient.new
    http_client.set_auth(domain, user, password)
    xml_doc = Nokogiri::XML(http_client.get(url).body)

    XmlToRadiatorTransformer.new.transform xml_doc
  end

  def pipeline_reducer radiator
    pipeline_include = configatron.pipeline.include.list.split(',')
    puts pipeline_include
    if pipeline_include.length > 0
      radiator.pipelines.delete_if {  |pipeline| !pipeline_include.include?(pipeline.name) }
    end

    radiator
  end

end