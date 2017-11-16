class MyStack
  def initialize
    @store = []
    @max = nil
    @min = nil
  end
  
  def push(el)
    @store.push(el)
    update_max
    update_min
    el
  end
  
  def pop
    
    @store.pop
  end
  
  def peek
    @store.dup
  end
  
  def size
    @store.length
  end
  
  def empty?
    @store.empty?
  end
  
  private
  
  def update_max
    if @max.nil? || el > @max 
      @max = el 
    end
  end
  
  def update_min
    if @min.nil? || el < @min 
      @min = el 
    end
  end
end