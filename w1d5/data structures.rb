class Stack
  def initialize
    @stack = []
  end

  def add(el)
    @stack << el
  end

  def remove
    @stack.pop
  end

  def show
    @stack
  end
end

class Queue
  def initialize
    @queue = []
  end

  def add(el)
    @queue.push(el)
  end

  def remove
    @queue.shift
  end

  def show
    @queue
  end

end

class Map
  def initialize
    @mapping = []
  end

  def assign(key,val)
    remove(key) unless lookup(key).nil?
    @mapping << [key,val]
  end

  def lookup(key)
    @mapping.each do |sub_array|
      return sub_array if sub_array.first == key
    end
    nil
  end

  def remove(key)
    unless lookup(key).nil?
      @mapping.reject! {|sub_array| sub_array[0] == key}
    end
  end

  def show
    @mapping
  end

end
