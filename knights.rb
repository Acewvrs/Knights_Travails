require 'pry'

class Knight
  attr_accessor :x
  attr_accessor :y
  attr_reader :available_tiles
  attr_accessor :moves_taken

  def initialize(x, y)
    @x = x
    @y = y
    @available_tiles = Array.new()
    @moves_taken = Array.new()
    find_available_tile()
  end
  
  def is_within_bounds(x_pos, x_move, y_pos, y_move)
    if x_pos + x_move >= 1 && x_pos + x_move <= 8 && y_pos + y_move >= 1 && y_pos + y_move <= 8
      return true
    end
    return false
  end

  def find_available_tile()
    @available_tiles.clear()
    moves = [-2, -1, 1, 2]
    ones = [-1, 1]
    twos = [-2, 2]
    to_tile = Array.new()

    for x in moves
      if x.abs() == 1
        for y in twos
          if is_within_bounds(@x, x, @y, y)
            to_tile = [@x + x, @y + y]
            @available_tiles.push(to_tile)
          end
        end
      else #x.abs() == 2
        for y in ones
          if is_within_bounds(@x, x, @y, y)
            to_tile = [@x + x, @y + y]
            @available_tiles.push(to_tile)
          end
        end
      end
    end
  end
end

#breadth-first search algorithm of finding the shortest path
def knight_moves(from_tile, to_tile) 
  first_knight = Knight.new(from_tile[0], from_tile[1])
  first_knight.moves_taken.push(from_tile)
  queue = Array.new()
  queue.push(first_knight)
  reached_tile = false
  tiles_already_taken = Array.new()

  while !reached_tile
    current_knight = queue[0]
    for tile in current_knight.available_tiles
      if !tiles_already_taken.include?(tile)
        tiles_already_taken.push(tile)
        tmp_knight = Knight.new(tile[0], tile[1])
        tmp_knight.moves_taken = current_knight.moves_taken.clone() #keep the original array
        tmp_knight.moves_taken.push(tile)
        queue.push(tmp_knight)
  
        if tile[0] == to_tile[0] && tile[1] == to_tile[1]
          return tmp_knight.moves_taken
        end
      end
    end
    queue.shift(1)
  end
end

shortest_path = knight_moves([1,1],[8,1])
puts "You made it in #{shortest_path.size - 1} moves!  Here's your path:"
p shortest_path