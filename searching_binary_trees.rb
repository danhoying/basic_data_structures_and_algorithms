# This project definitely gave me some trouble.  Thanks to some previous students'
# solutions for providing some scaffolding for my own solution, particularly
# Tommy Noe and Brann James.

class Tree
  attr_accessor :root

  def initialize(value = nil)
    @root = nil
  end

  def add_node(value, current = nil)
    if @root.nil?
      @root = Node.new(value)
      current = @root
    elsif value <= current.value
      current.left_child.nil? ? current.left_child = Node.new(value) : add_node(value, current.left_child)
    elsif value >= current.value
      current.right_child.nil? ? current.right_child = Node.new(value) : add_node(value, current.right_child)
    end
  end

  def build_tree(values)
    values.shuffle!
    values.each { |value| add_node(value, @root) }
  end

  def breadth_first_search(search_value)
    queue = [@root]
    until queue.empty?
      current = queue.shift
      if current.value == search_value
        puts "The value #{search_value} was found."
        return current
      else
        queue << current.left_child if current.left_child
        queue << current.right_child if current.right_child
      end
    end
    puts "The value #{search_value} was not found."
    return nil
  end

  def depth_first_search(search_value)
    stack = [@root]
    discovered = []
    until stack.empty?
      current = stack.pop
      discovered << current
      if current.value == search_value
        puts "The value #{search_value} was found."
        return current
      else
        stack.push(current.left_child) if current.left_child && !discovered.include?(current.left_child)
        stack.push(current.right_child) if current.right_child && !discovered.include?(current.right_child)
      end
    end
    puts "The value #{search_value} was not found."
    return nil
  end

  def dfs_rec(search_value, current = @root)
    if current.value == search_value
      puts "The value #{search_value} was found."
      return current 
    end
    left_search = dfs_rec(search_value, current.left_child) if current.left_child
    return left_search if !left_search.nil?
    right_search = dfs_rec(search_value, current.right_child) if current.right_child
    return right_search if !right_search.nil?
  end
end

class Node
  attr_accessor :value, :parent, :left_child, :right_child

  def initialize(value, parent = nil, left_child = nil, right_child = nil)
    @value = value
    @parent = parent
    @left_child = left_child
    @right_child = right_child
  end
end

tree = Tree.new
tree.build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
# => [6345, 324, 5, 1, 7, 4, 23, 7, 9, 67, 3, 9, 4, 8]
tree.breadth_first_search(67) # => The value 67 was found.
tree.breadth_first_search(33) # => The value 33 was not found.
tree.depth_first_search(23) # => The value 23 was found.
tree.depth_first_search(44) # => The value 44 was not found.
tree.dfs_rec(23) # => The value 23 was found.