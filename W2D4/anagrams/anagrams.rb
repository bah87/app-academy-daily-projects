require 'byebug'
def first_anagram?(string, string2)
  anagram_arr = permutations(string)
  anagram_arr.include?(string2)
end

def permutations(string)
  return [string] if string.length <= 1
  
  perms = []
  
  string.chars.each do |chr|
    sub_str = string.dup
    sub_str.delete!(chr)
    permutations(sub_str).each do |str|
      perms << str + chr
    end
  end
  perms
end
#--------------------------------#
def second_anagram?(string,string2)
  return false unless string.length == string2.length
  
  string_1 = string.dup
  string_2 = string2.dup 
  
  string.chars.each do |chr1|
    string2.chars.each do |chr2|
      if chr1 == chr2
        string_1.delete!(chr1)
        string_2.delete!(chr1)
      end
    end
  end
  
  string_1.empty? && string_2.empty?
end
#--------------------------------#
def third_anagram?(string, string2)
  merge_sort(string.chars) == merge_sort(string2.chars)
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
#--------------------------------#
def fourth_anagram?(str_1, str_2)
  freq = Hash.new(0)
  
  str_1.chars.each do |chr|
    freq[chr] += 1
  end 
  
  str_2.chars.each do |chr|
    freq[chr] -= 1
  end 
  
  freq.values.all? { |v| v.zero? }
end