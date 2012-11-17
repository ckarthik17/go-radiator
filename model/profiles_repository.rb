require_relative 'profiles'

class ProfilesRepository

  def initialize(file_name)
    @file_path = file_name
  end

  def get(profile_name)
    profiles = get_all.profiles
    profiles.find {|profile| profile.name == profile_name}
  end

  def get_all
    file = IO.read(@file_path)
    Profiles.new(JSON.parse(file))
  end

  def save(profile)
    file = IO.read(@file_path)
    profiles = Profiles.new(JSON.parse(file))

    duplicate = false
    profiles.profiles.each do |p|
      duplicate = true if p.name.downcase == profile.name.downcase
    end

    unless duplicate
      profiles.profiles.push(profile)
      save_to_file(profiles)
    end

    !duplicate
  end

  def delete(name)
    file = IO.read(@file_path)
    profiles = Profiles.new(JSON.parse(file))
    profiles.profiles.each do |profile|
      if profile.name.downcase == name.downcase
        profiles.profiles.delete(profile)
      end
    end

    save_to_file(profiles)

    true
  end

  private
  def save_to_file(profiles)
    json_string = JSON.pretty_generate(profiles.to_hash)

    File.open(@file_path, "wb") {|f| f.write(json_string)}
  end
end