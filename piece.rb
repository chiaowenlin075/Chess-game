# encoding: utf-8
class Piece

attr_reader :team
attr_accessor :pos, :board
  def initialize(pos, board, team)
    @pos = pos
    @board = board
    @team = team
  end

  # def move(new_pos) # move one single piece to new position
  #   board.move_pieces(pos, new_pos)
  #   self.turn += 1 if self.class == Pawn
  # end

  def safe_moves
    valid_moves.select { |move| !move_into_check?(move) }
  end

  def win_moves
    safe_moves.select { |move| move_into_win?(move) }
  end

  def move_into_check?(new_pos)
    dup_board = board.deep_dup
    dup_board.move!(pos, new_pos)
    dup_board.in_check?(team)
  end

  def move_into_win?(new_pos)
    oppo_team = team == :white ? :black : :white
    dup_board = board.deep_dup
    dup_board.move(pos, new_pos)
    dup_board.in_check?(oppo_team)
  end

  def inspect
    "#{self.class}, #{team}"
  end

  private

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
