require_relative 'p01_int_set'
require_relative 'p02_hashing'

class HashSet < ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    super
  end

  private

  def [](num)
    @store[num.hash % num_buckets]
  end
end
