class Board

  attr_reader :grid

  def initialize(size = 9, bombs = 1)
    @grid = Array.new(size) { Array.new(size) }
    populate_grid(bombs)
    ready_tiles
  end

  def populate_grid(bombs)
    safe_spaces = @grid.length ** 2 - bombs
    bombs = Array.new(bombs) { Tile.new(true) }
    empty_tiles = Array.new(safe_spaces) { Tile.new }
    tiles = bombs.concat(empty_tiles).shuffle
    @grid.length.times do |i|
      @grid.length.times do |j|
        @grid[i][j] = tiles.pop
        @grid[i][j].pos = [i, j]
      end
    end
  end

  def display
    disp = "  " + (0...grid[0].length).to_a.join(" ") + "\n"
    disp += @grid.map.with_index do |row, index|

      "#{index.to_s} " + row.map do |tile|
        if tile.flag
          "f"
        elsif tile.revealed
          tile.symbol
        else
          "⬜"
        end
      end.join(" ")
    end.join("\n")
    puts disp
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def ready_tiles
    @grid.each do |row|
      row.each do |tile|
        tile.find_neighbors(@grid)
      end
    end

    @grid.each do |row|
      row.each do |tile|
        tile.assign_numbers
      end
    end
  end

  def reveal_bombs
    grid.each do |row|
      row.each do |tile|
        tile.reveal if tile.bomb
      end
    end
  end
end
