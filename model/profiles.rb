require_relative 'JSONable'

class Profiles
  include JSONable

  attr_reader :profiles

  def initialize(profiles_hash)
    @profiles = []
    profiles_from_hash(profiles_hash)
  end

  private
  def profiles_from_hash(profiles_hash)
    profiles_array = profiles_hash["profiles"]
    return if profiles_array.nil?
    profiles_array.each do |profile_hash|
      @profiles.push(Profile.profile_from_hash(profile_hash))
    end
  end
end


class Profile
  include JSONable

  attr_reader :name, :pipelines

  def initialize(name, pipelines)
    @name = name
    @pipelines = pipelines
  end

  def self.profile_from_hash(profile_hash)
    name = profile_hash["name"]
    pipelines = profile_hash["pipelines"]
    Profile.new(name, pipelines)
  end
end