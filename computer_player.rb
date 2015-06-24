class ComputerPlayer
  attr_reader :team, :board

  def initialize(board,team)
    @board, @team = board, team
  end

  def play_turn
    board.show_board
    puts "Team #{team}, please choose a piece to move (ex: F2): "
    from_piece = choose_from_piece
    from_pos = from_piece.pos
    from_pos_show = idx_to_show_pos(from_pos)
    puts from_pos_show

    puts "Please choose a place to move to (ex: F3): "
    end_pos = choose_to_pos(from_piece)
    end_pos_show = idx_to_show_pos(end_pos)
    puts end_pos_show

    board.move(from_pos, end_pos)
  end

  def idx_to_show_pos(pos)
    col, row = nil, nil
    pos.each_with_index do |el,idx|
      if idx == 0
        row = Board::ROWS.key(el)
      else
        col = Board::COLS.key(el)
      end
    end
    "#{col}#{row}"
  end

  def choose_to_pos(from_piece)
    if from_piece.win_moves.empty?
      from_piece.safe_moves.sample
    else
      from_piece.win_moves.sample
    end
  end

  def choose_from_piece
    if board.win_move_pieces(team).empty?
      board.moveable_pieces(team).sample
    else
      board.win_move_pieces(team).sample
    end
  end
end
