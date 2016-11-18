require_relative 'board'
require_relative 'tile'

class Game
  attr_reader :board

  def initialize(size)
    @board = Board.new(size)
  end

  def play

  end

  def get_move
    puts "Select a tile"
    move = gets.chomp
    row, col = move[0].to_i, move[-1].to_i
    [row, col]
  end

  def valid_move(move)
    !@board[move].revealed
  end

  def handle_move(move)
    @board[move].reveal
    handle_loss if @board[move].bomb

  end

  def handle_loss
    puts "You blew up a mine!"
    @board.reveal_bombs
  end

  # def over?
  #   @board.each do |row|
  #     row.each do |tile|
  #       return false if !tile.reveal && !tile.bomb
  #     end
  #   end

  # end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new(4)
  game.board.grid[1][2].reveal
  game.board.display
end
