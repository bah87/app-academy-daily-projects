class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    numberized_arr.to_s.chars.map(&:ord).join.to_i.hash
  end
  
  def numberized_arr
    self.map do |el|
      if el.is_a?(Integer)
        el 
      elsif el.is_a?(Hash)
        el.hash
      elsif el.is_a?(Array)
        el.hash
      else
        el.to_s.chars.map(&:ord).join.to_i
      end 
    end
  end
end

class String
  def hash
    self.chars.map(&:ord).join.to_i.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.sort.hash
  end
end
