class Game
  attr_reader :board
  attr_accessor :current_player

  def initialize
    @board = Board.new
    @player1 = HumanPlayer.new(board, :white)
    @player2 = HumanPlayer.new(board, :black)
    @current_player = @player1
  end

  def play
    loop do
      current_player.play_turn
      oppo_player = current_player == @player1 ? @player2 : @player1
      if board.checkmate?(oppo_player.team)
        puts "Congrats! Team #{current_player.team} you win!"
        break
      end
      self.current_player = current_player == @player1 ? @player2 : @player1
    end
  end

end
