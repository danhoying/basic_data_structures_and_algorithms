class KnightMoves

  attr_accessor :board, :knight

  def initialize(start_square, end_square)
    @knight = Knight.new("white", ("\u265E"), start_square, end_square)
    @start_square = start_square
    @end_square = end_square
    @board = Board.new(@start_square, @end_square)
  end

  def start
    knight_moves(@start_square, @end_square)
  end

  def knight_moves(start_square, end_square)
    node = Node.new(start_square)
    queue = [node]
    until node.value == end_square    
      node = queue.shift
      if node.value == end_square
        history = find_history(node) 
        history.reverse.each do |i|
          @board.move(@knight, i)
          @board.display_board
          sleep 1
        end
        puts ""
        puts "You made it in #{history.size - 1} moves! Here's your path: "
        history.reverse.each { |move| p move }
      end
      valid_moves = possible_moves(node)
      valid_moves.each do |move|
        node2 = Node.new(move, node)
        queue << node2
      end  
    end
  end

  def find_history(node)
    history = []
    history << node.value
    until node.parent.nil?
      history << node.parent.value
      node = node.parent
    end
    history
  end

  def possible_moves(node)
    valid_moves = []
    c = node.value[0]
    r = node.value[1]
    possible_moves = [[c + 2, r + 1], [c + 2, r - 1], [c - 2, r + 1], [c - 2, r - 1],
                      [c + 1, r + 2], [c - 1, r + 2], [c + 1, r - 2], [c - 1, r - 2]]
    possible_moves.each do |move|
      if move.all? { |value| value > 0 } && move.all? { |value| value < 7 }
        valid_moves << move
      end
    end
    return valid_moves
  end

end

class Knight

  attr_accessor :color, :symbol, :start_square, :end_square

  def initialize(color, symbol, start_square, end_square)
    @color = color
    @symbol = symbol
    @start_square = start_square
    @end_square = end_square
  end

end

class Board

  def initialize(start_square, end_square)
    @knight = Knight.new("white", ("\u265E"), start_square, end_square)
    @board = create_board
    @empty_square = "___"
  end

  def create_board
    board = []
    8.times do 
      board.push(["___", "___", "___", "___", "___", "___", "___", "___"])
    end
    board[@knight.start_square[0]][@knight.start_square[1]] = @knight
    board[@knight.end_square[0]][@knight.end_square[1]] = "end"
    board
  end

  def display_board
    count = 9 # For labeling numbers on side of board
    puts ""
    puts "  _a_ _b_ _c_ _d_ _e_ _f_ _g_ _h_"
    @board.reverse.each do |row|
      print "#{count - 1}|"
      row.each do |item|
        if !item.instance_of? String
            print "_#{item.symbol}_|"
        else
          print "#{item}|"
        end
      end
      print "#{count - 1}"
      count -= 1
      puts " "
    end
     print "   a   b   c   d   e   f   g   h" 
     puts ""
     @board
  end

  def move(knight, current_square) 
    knight.start_square = current_square
    @board[knight.start_square[0]][knight.start_square[1]] = knight
  end
end

class Node

  attr_accessor :value, :parent

  def initialize(value, parent = nil)
    @value = value
    @parent = parent
  end
end

knights_travails = KnightMoves.new([7, 0], [3, 3])
knights_travails.start

#   _a_ _b_ _c_ _d_ _e_ _f_ _g_ _h_
# 8|_♞_|___|___|___|___|___|___|___|8 
# 7|___|___|___|___|___|___|___|___|7 
# 6|___|___|___|___|___|___|___|___|6 
# 5|___|___|___|___|___|___|___|___|5 
# 4|___|___|___|end|___|___|___|___|4 
# 3|___|___|___|___|___|___|___|___|3 
# 2|___|___|___|___|___|___|___|___|2 
# 1|___|___|___|___|___|___|___|___|1 
#    a   b   c   d   e   f   g   h

#   _a_ _b_ _c_ _d_ _e_ _f_ _g_ _h_
# 8|_♞_|___|___|___|___|___|___|___|8 
# 7|___|___|_♞_|___|___|___|___|___|7 
# 6|___|___|___|___|___|___|___|___|6 
# 5|___|___|___|___|___|___|___|___|5 
# 4|___|___|___|end|___|___|___|___|4 
# 3|___|___|___|___|___|___|___|___|3 
# 2|___|___|___|___|___|___|___|___|2 
# 1|___|___|___|___|___|___|___|___|1 
#    a   b   c   d   e   f   g   h

#   _a_ _b_ _c_ _d_ _e_ _f_ _g_ _h_
# 8|_♞_|___|___|___|___|___|___|___|8 
# 7|___|___|_♞_|___|___|___|___|___|7 
# 6|___|___|___|___|___|___|___|___|6 
# 5|___|_♞_|___|___|___|___|___|___|5 
# 4|___|___|___|end|___|___|___|___|4 
# 3|___|___|___|___|___|___|___|___|3 
# 2|___|___|___|___|___|___|___|___|2 
# 1|___|___|___|___|___|___|___|___|1 
#    a   b   c   d   e   f   g   h

#   _a_ _b_ _c_ _d_ _e_ _f_ _g_ _h_
# 8|_♞_|___|___|___|___|___|___|___|8 
# 7|___|___|_♞_|___|___|___|___|___|7 
# 6|___|___|___|___|___|___|___|___|6 
# 5|___|_♞_|___|___|___|___|___|___|5 
# 4|___|___|___|_♞_|___|___|___|___|4 
# 3|___|___|___|___|___|___|___|___|3 
# 2|___|___|___|___|___|___|___|___|2 
# 1|___|___|___|___|___|___|___|___|1 
#    a   b   c   d   e   f   g   h

# You made it in 3 moves! Here's your path: 
# [7, 0]
# [6, 2]
# [4, 1]
# [3, 3]
