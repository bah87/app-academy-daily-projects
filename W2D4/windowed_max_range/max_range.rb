def windowed_max_range(arr, window)
  windows = arr.each_cons(window)
  current_max_range = nil
  
  windows.each do |sub_arr|
    range = sub_arr.max - sub_arr.min 
    if current_max_range.nil? || range > current_max_range
      current_max_range = range 
    end
  end 
  
  current_max_range
end

p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8

