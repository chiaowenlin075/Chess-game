class HumanPlayer
  attr_reader :team, :board

  def initialize(board,team)
    @board, @team = board, team
  end

  def play_turn
    begin
      board.show_board
      puts "Team #{team}, please choose a piece to move (ex: F2): "
      from_pos = check_from_pos
      begin
        puts "Please choose a place to move to (ex: F3): "
        to_pos = input_position
      rescue InvalidInputError
        puts "Invalid new position, please choose again or 'q' to choose another piece: "
        retry
      end
      board.move(from_pos, to_pos)
    rescue InvalidPieceError
      puts "Invalid start position, please choose again!"
      retry
    rescue ReChoosePieceError
      retry
    rescue NotValidMoveError
      puts "Not a valid move, please choose again!"
      retry
    rescue UnsafeMoveError
      puts "Not a safe move, might make you in check, please choose again!"
      retry
    end
  end

  def input_position
    position = gets.chomp.strip.split("")
    raise ReChoosePieceError if position.first == 'q'
    raise InvalidInputError if position.size != 2 ||
                                (position.first =~ /^[A-Ha-h]$/) == nil ||
                                (position.last =~ /^[1-8]$/) == nil
    col = Board::COLS[position.first.upcase]
    row = Board::ROWS[position.last]

    pos = [row, col]
  end

  def check_from_pos
    pos = input_position
    raise InvalidPieceError if pos.include?(nil) ||
                                 board.empty?(pos) ||
                                 board[pos].team != team
    pos
  end
end

class InvalidInputError < StandardError
end

class ReChoosePieceError < StandardError
end

class InvalidPieceError < StandardError
end
