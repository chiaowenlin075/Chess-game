class Piece

attr_reader :team
attr_accessor :pos, :board
  def initialize(pos, board, team)
    @pos = pos
    @board = board
    @team = team
  end

  def move(new_pos)
    board.move_pieces(pos, new_pos)
    self.turn += 1 if self.class == Pawn
  end

  def available_pos?(another_pos) # either empty or opponent
    return false unless board.in_board?(another_pos)
    board.empty?(another_pos) || !same_team?(another_pos)
  end

  def same_team?(another_pos) # piece is diff team
    board[another_pos].team == team
  end

  def in_board_and_diff_team?(another_pos)
    board.in_board?(another_pos) && !board.empty?(another_pos) && !same_team?(another_pos)
  end

  def new_pos(dir)
    [pos[0] + dir[0] , pos[1] + dir[1]]
  end
end
