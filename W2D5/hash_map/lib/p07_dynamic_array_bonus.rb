class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable
  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    @store[i]
  end

  def []=(i, val)
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    self.each do |el|
      return true if val == el
    end
    
    false
  end

  def push(val)
    resize! if count == capacity
    @store[count] = val
    @count += 1
  end

  def unshift(val)
    store = @store.dup
    @store[0] = val
    store[0..-2].each.with_index do |el, idx|
      @store[idx+1] = el
    end
    
    self.push(store[-1])
    
    
    @count += 1
    @store
  end

  def pop
    return nil if count.zero?
    popped = @store[count-1]
    @store[count-1] = nil
    @count -= 1
    popped
  end

  def shift
    @store.shift
    @count -= 1
  end

  def first
    @store[0]
  end

  def last
    @store[count-1]
  end

  def each(&prc)
    i = 0
    while i < capacity
      prc.call(self[i])
      i += 1
    end 
    
    self
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    
  end
end
