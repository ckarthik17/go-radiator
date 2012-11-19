require "rubygems"
require "bundler/setup"

require "sinatra"
set :protection, except: :ip_spoofing

require "sinatra/content_for"
require "haml"
require "json"
require "nokogiri"
require "httpclient"
require "configatron"

require_relative "model/retriever"
require_relative "model/profiles_repository"
require_relative "config/config"

before do
  @profiles_repository = ProfilesRepository.new(File.dirname(__FILE__) + '/db/profiles.json')
end

# API METHODS - Supporting Application/json
get '/?' do
  content_type :json
  status 200

  Retriever.new.get_data.to_json
end

get '/profiles/?' do
  content_type :json
  status 200

  @profiles_repository.get_all.to_json
end

post '/profile/?' do
  content_type :json
  status 201

  profile_hash = JSON.parse(request.body.read)
  profile = Profile.profile_from_hash(profile_hash)
  result = @profiles_repository.save(profile)
  status 400 unless result
end

delete '/profile/:name/?' do
  content_type :json
  status 200

  @profiles_repository.delete(params[:name])
end

# UI Methods
get '/admin/?' do
  radiator = Retriever.new.get_data
  pipeline_names = []
  radiator.pipelines.each do |p|
    pipeline_names << p.name
  end
  pipeline_names = pipeline_names.sort
  profiles = @profiles_repository.get_all.profiles

  haml :admin, :locals => {:pipeline_names => pipeline_names, :profiles => profiles}, :format => :html5
end

get '/radiator/?' do
  profiles = @profiles_repository.get_all.profiles

  haml :setup, :locals => {:profiles => profiles}, :format => :html5
end

get '/radiator/:profile/?' do
  radiator = Retriever.new.get_data(@profiles_repository.get(params[:profile]).pipelines)
  rows = []
  radiator.pipelines.each_slice(3) do |x,y,z|
    rows << [x,y,z]
  end

  haml :index, :locals => {:rows => rows}, :format => :html5
end

