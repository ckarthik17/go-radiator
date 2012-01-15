require "rubygems"
require "bundler/setup"

require 'sinatra/base'
require 'json'
require 'haml'
require 'nokogiri'
require 'httpclient'

require_relative 'retriever'

class GoRadiator < Sinatra::Base

  get '/' do
    content_type :json
    Retriever.new.get_data.to_json
  end

  get '/radiator' do
    @radiator = Retriever.new.get_data
    haml :radiator, :format => :html5
  end

  get '/pipeline/:name' do
    @pipeline = Retriever.new.get_data.get_pipeline(params[:name])
    haml :pipeline, :format => :html5, :layout => false
  end
end