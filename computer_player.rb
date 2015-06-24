class HumanPlayer
  attr_reader :team, :board

  def initialize(board,team)
    @board, @team = board, team
  end

  def play_turn
    board.show_board
    puts "Team #{team}, please choose a piece to move (ex: F2): "
    from_piece = choose_from_piece
    puts from_piece.pos

    puts "Please choose a place to move to (ex: F3): "
    end_pos = choose_to_pos(from_piece)
    puts end_pos

    board.move(from_piece.pos, end_pos)
  end

  def choose_to_pos(from_piece)
    from_piece.safe_moves.sample
  end

  def choose_from_piece
    board.moveable_pieces(team).sample
  end
end
