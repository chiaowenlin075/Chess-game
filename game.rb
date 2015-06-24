class Game
  attr_reader :board
  attr_accessor :current_player

  def initialize
    initial_cond = decide_players
    @board = initial_cond[:board]
    @player1 = initial_cond[:player1]
    @player2 = initial_cond[:player2]
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

  def decide_players
    puts "Type 1 for single player against computer, 2 for 2 players: "
    num_of_players = gets.chomp.to_i

    initial_cond = {}
    board = Board.new
    initial_cond[:board] = board
    initial_cond[:player1] = HumanPlayer.new(board, :white)
    if num_of_players == 1
      initial_cond[:player2] = ComputerPlayer.new(board, :black)
    else
      initial_cond[:player2] = HumanPlayer.new(board, :black)
    end

    initial_cond
  end

end
