module JSONable

  def to_hash
    hash = {}
    self.instance_variables.each do |var|
      hash[var.to_s.delete!('@')] = self.instance_variable_get var
    end
    array_check hash

    hash
  end

  def to_json
    hash = {}
    self.instance_variables.each do |var|
      hash[var.to_s.delete!('@')] = self.instance_variable_get var
    end
    array_check hash

    hash.to_json
  end

  def array_check hash
    hash.keys.each do |key|
      if hash[key].class == Array
        array = []
        hash[key].each do |element|
          array << hash_object(element)
        end
        hash[key] = array
      end
    end

    hash
  end

  def hash_object object
    hash = {}
    object.instance_variables.each do |var|
      hash[var.to_s.delete!('@')] = object.instance_variable_get var
    end
    array_check hash

    hash
  end
end