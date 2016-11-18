require 'byebug'
class Tile
  DIRECTIONS = {
    n: [0, 1],
    ne: [1, 1],
    e: [1, 0],
    se: [1, -1],
    s: [0, -1],
    sw: [-1, -1],
    w: [-1, 0],
    nw: [-1, 1]
   }

   TILE_VIEW = {
     bomb: "*",
     flag: "f",
     tile: "⬜",
     revealed: " "
   }

  attr_reader :bomb, :flag, :symbol, :revealed
  attr_accessor :pos, :neighbor_bombs

  def initialize(bomb = false)
    @bomb = bomb
    @neighbors = []
    @flag = false
    @revealed = false
    @symbol = (bomb ? TILE_VIEW[:bomb] : nil)
    @neighbor_bombs = 0
  end

  def reveal
    @revealed = true
  end

  def find_neighbors(grid)
    DIRECTIONS.each do |_, val|
      neighbor_pos = Vector.new(val).add(Vector.new(pos))
      unless neighbor_pos.x < 0 || neighbor_pos.y < 0 ||
        neighbor_pos.x > grid.length - 1 || neighbor_pos.y > grid[0].length - 1
        neighbor = grid[neighbor_pos.x][neighbor_pos.y]
        @neighbors << neighbor unless neighbor.nil?
      end
    end
  end

  def assign_numbers
    @neighbor_bombs = @neighbors.count { |t| t.bomb }
    @symbol = @neighbor_bombs.to_s unless @bomb
    # debugger
    @symbol = " " if @symbol.to_i === 0
    @symbol = TILE_VIEW[:bomb] if bomb
  end

  def toggle_flag
    @flag = !@flag
  end
end

class Vector
  attr_reader :x, :y

  def initialize(pos)
    @x = pos[0]
    @y = pos[1]
  end

  def add(vector)
    Vector.new([vector.x + x, vector.y + y])
  end
end
