require "rubygems"
require "bundler/setup"

require 'sinatra'
require 'json'

require_relative 'xml_to_radiator_transformer'

get '/' do
  file = File.open('sample_data.xml')
  xml_doc = Nokogiri::XML(file)
  file.close

  radiator = XmlToRadiatorTransformer.new.transform xml_doc

  content_type :json
  radiator.to_json
end

get '/view' do

end