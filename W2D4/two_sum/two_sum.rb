def bad_two_sum?(arr, target_sum)
  arr.each_with_index do |el1, i|
    arr.each_with_index do |el2, j|
      next if i == j
      return true if el1 + el2 == target_sum
    end 
  end
  false
end


def okay_two_sum?(arr, target_sum)
  sorted_arr = merge_sort(arr)
  
  small_i = 0
  large_i = arr.length - 1
  
  until small_i == large_i
    if sorted_arr[small_i] + sorted_arr[large_i] == target_sum
      return true 
    elsif sorted_arr[small_i] + sorted_arr[large_i] > target_sum
      large_i -= 1 
    else
      small_i += 1
    end
  end
  false
end

def merge_sort(arr)
  return arr if arr.length < 2 
  
  mid_i = arr.length / 2
  
  left = arr.take(mid_i)
  right = arr.drop(mid_i)
  
  merge(merge_sort(left),merge_sort(right))
end 

def merge(left,right)
  merged = [] 
  
  until left.empty? || right.empty?
    if left.first < right.first
      merged << left.shift
    else
      merged << right.shift
    end 
  end
  
  merged + left + right
end

def two_sum?(arr, target_sum)
  hash = Hash.new(0)
  
  arr.each do |el|
    hash[el] += 1
  end 
  
  arr.each do |el|
    if target_sum - el == el
      return true if hash[target_sum - el] > 1
    elsif hash[target_sum - el] > 0
      return true
    end      
  end 
  
  false
end