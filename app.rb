require "rubygems"
require "bundler/setup"

require "sinatra"
require "haml"
require "json"
require "nokogiri"
require "httpclient"

require_relative "model/retriever"

get '/' do
  content_type :json
  Retriever.new.get_data.to_json
end

get '/radiator' do
  #@radiator = Retriever.new.get_data
  @pipeline = Retriever.new.get_data.get_pipeline("Middleware_CI")
  progress_css = progress_bar_setting
  haml :index, :locals => {:progress_css => progress_css}, :format => :html5
end

get '/pipeline/:name' do
  @pipeline = Retriever.new.get_data.get_pipeline(params[:name])
  haml :pipeline, :format => :html5, :layout => false
end

private
def progress_bar_setting
  progress_css = ''
  return 'progress-warning progress-striped active' if @pipeline.current_stage.first.status == 'building'
  return 'progress-success' if @pipeline.current_stage.first.status == 'success'
  return 'progress-danger' if @pipeline.current_stage.first.status == 'failure'

  progress_css
end