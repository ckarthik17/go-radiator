require "rubygems"
require "bundler/setup"

require "sinatra"
require "haml"
require "json"
require "nokogiri"
require "httpclient"

require_relative "model/retriever"
require_relative "config/config"

get '/' do
  content_type :json
  Retriever.new.get_data.to_json
end

get '/admin' do
  haml :admin, :format => :html5
end

get '/radiator' do
  radiator = Retriever.new.get_data
  rows = []
  radiator.pipelines.each_slice(3) do |x,y,z|
    rows << [x,y,z]
  end

  haml :index, :locals => {:rows => rows}, :format => :html5
end