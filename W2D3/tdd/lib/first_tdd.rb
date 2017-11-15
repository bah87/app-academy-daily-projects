class Array 
  
  def my_uniq 
    result = []
    self.each do |el|
      result << el unless result.include?(el)
    end
    
    result
  end
  
  def two_sum 
    result = []
    
    (0...self.length-1).each do |idx1|
      (idx1+1...self.length).each do |idx2|
        sum = self[idx1] + self[idx2]
        result << [idx1, idx2] if sum == 0 
      end
    end
    
    result
  end
  
  def my_transpose
    result = []
    (0...self.length).each do |idx|
      new_row = []
      self.each do |row|
        new_row << row[idx]
      end
      result << new_row
    end
    
    result
  end
  
  def stock_picker
    days = [0,1]
    profit = self[1] - self[0]
    (0...self.length-1).each do |idx1|
      (idx1+1...self.length).each do |idx2|
        if self[idx2] - self[idx1] > profit
          profit = self[idx2] - self[idx1]
          days = [idx1, idx2]
        end
      end
    end
    
    days
  end
  
end

class DiscError < StandardError
end

class Towers
  attr_reader :towers 
  
  def initialize(towers = [[3,2,1], [], []])
    @towers = towers
  end
  
  def get_input
    
  end
  
  def move(from, to)
    if !self.towers[to].empty? && self.towers[from].last > self.towers[to].last
      raise DiscError
    elsif self.towers[from].empty?
      raise DiscError
    end
    
    disc = self.towers[from].pop
    self.towers[to] << disc
  end
  
  def won?
    self.towers == [[], [], [3,2,1]] ||
    self.towers == [[], [3,2,1], []]
  end
end