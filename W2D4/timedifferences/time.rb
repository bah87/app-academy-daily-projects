require 'byebug'
def my_min_1(list)
  arr = list 
  sorted = false
  
  until sorted
    sorted = true 
    arr[0..-2].each_index do |i|
      if arr[i] > arr[i+1]
        arr[i], arr[i+1] = arr[i+1], arr[i]
        sorted = false
      end
    end
  end
  
  arr.first
end

def my_min_2(list)
  min = list.first
  
  list.drop(1).each do |el|
    min = el if el < min
  end
  
  min
  
end

def l_cont_sum_1(arr)
  sub_arr =[]
  
  (0...arr.length).each do |i|
    (i...arr.length).each do |j|
      sub_arr << arr[i..j]
    end
  end
  
  sum = sub_arr.first.reduce(:+)
  sub_arr.drop(1).each do |arr|
    temp_sum = arr.reduce(:+)
    sum = temp_sum if temp_sum > sum 
  end 
  
  sum
end

def l_cont_sum_2(arr)
  if arr.all? { |el| el < 0 }
    max = arr.first
    (1...arr.length).each do |i|
      max = arr[i] if arr[i] > max 
    end 
    
    return max
  end
  
  
  max = arr.first
  sum = arr.first
  (1...arr.length).each do |i|
    if arr[i] + sum > max 
      max = arr[i] + sum
      sum = max 
    elsif arr[i] + sum < 0
      sum = 0
    elsif arr[i] + sum > 0
      sum += arr[i]
      max = sum if sum > max
    end 
  end
  
  max
end

p l_cont_sum_2([5, 3, -7])
p l_cont_sum_2([2, 3, -6, 7, -6, 7])
p l_cont_sum_2([-5, -1, -3])





















