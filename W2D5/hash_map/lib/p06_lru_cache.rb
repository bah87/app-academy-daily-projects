require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    unless @map.include?(key)
      calc!(key)
    else
      update_node!(@map.get(key))
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    value = @prc.call(key)
    @store.append(key, value) #2 ==> 4
    @map.set(key, @store.last) #2 ==> Node
    eject! if count > @max
    value
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    node.remove
    @store.append(node.key, node.val)
    @map.set(node.key, @store.last)
    node.val
  end

  def eject!
    key = @store.first.key
    @store.first.remove
    @map.delete(key)
  end
end
