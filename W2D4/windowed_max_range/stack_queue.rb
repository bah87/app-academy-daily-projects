require_relative 'stack'

class StackQueue
  def initialize
    @in_stack = MyStack.new
    @out_stack = MyStack.new
  end
  
  def enqueue(el)
    @in_stack.push(el)
  end
  
  def dequeue
    raise "StackQueue empty" if self.empty?
    refresh if @out_stack.empty?
    @out_stack.pop
  end
  
  def size
    @in_stack.size + @out_stack.size
  end
  
  def empty?
    @in_stack.empty? && @out_stack.empty?
  end
  
  private
  
  def refresh
    until @in_stack.empty?
      @out_stack.push(@in_stack.pop)
    end
  end
end