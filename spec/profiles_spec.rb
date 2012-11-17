require_relative 'lib/spec_helper'

describe "Profiles" do

  before(:each) do
    @file_path = File.dirname(__FILE__) + "/profiles_test.json"

    File.open(@file_path, "wb") {|f| f.write("{}")}
  end

  context "add profile" do
    it "should add a profile to the db store" do
      profiles_repository = ProfilesRepository.new(@file_path)

      new_profile = Profile.new("Thomas", "test")

      result = profiles_repository.save(new_profile)
      result.should == true
      profiles = profiles_repository.get_all

      profiles.profiles.count == 1
      profiles.profiles[0].name == "Thomas"
    end

    it "should not allow you to add a profile with a duplicate name" do
      profiles_repository = ProfilesRepository.new(@file_path)

      new_profile = Profile.new("Thomas", "test")
      result = profiles_repository.save(new_profile)
      result.should == true

      profiles = profiles_repository.get_all
      profiles.profiles.count == 1

      duplicate_profile = Profile.new("thomas", "test")
      duplicate_result = profiles_repository.save(duplicate_profile)
      duplicate_result.should == false

      profiles = profiles_repository.get_all
      profiles.profiles.count == 1
    end

  end

  context "delete profile" do
    it "should delete a profile from the db store" do
      profiles_repository = ProfilesRepository.new(@file_path)

      new_profile = Profile.new("Thomas", "test")
      profiles_repository.save(new_profile)
      profiles = profiles_repository.get_all
      profiles.profiles.count == 1

      profiles_repository.delete("thomas")

      profiles = profiles_repository.get_all

      profiles.profiles.count == 0
    end
  end

  context "get profile" do
    it "should return requested profile" do
      profiles_repository = ProfilesRepository.new(@file_path)

      new_profile = Profile.new("thomas", "test")
      profiles_repository.save(new_profile)
      profile = profiles_repository.get("thomas")

      profile.name.should == new_profile.name
      profile.pipelines.should == new_profile.pipelines
    end
  end
end