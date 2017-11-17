class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    self.prev.next = self.next
    self.next.prev = self.prev
  end
end

class LinkedList
  include Enumerable
  
  attr_reader :head, :tail
  
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def empty?
    @head.next == @tail
  end
  
  def first
    @head.next
  end
  
  def last
    @tail.prev
  end

  def get(key)
    self.each do |node|
      return node.val if node.key == key
    end
    nil
  end

  def include?(key)
    self.each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    node = Node.new(key, val)
    if empty?
      node.next = @tail
      node.prev = @head
      @head.next = node
      @tail.prev = node
    else
      second_to_tail = @tail.prev 
      second_to_tail.next = node 
      node.next = @tail 
      node.prev = second_to_tail
      @tail.prev = node 
    end    
  end

  def update(key, val)
    self.each do |node|
      if node.key == key
        node.val = val
      end
    end
  end

  def remove(key)
    self.each do |node|
      if node.key == key
        node.remove
        break
      end
    end
  end

  def each(&prc)
    prc ||= Proc.new { |node| node }
    node = @head
    until node == @tail.prev
      node = node.next
      prc.call(node)
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
