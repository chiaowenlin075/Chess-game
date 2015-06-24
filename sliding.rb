# encoding: utf-8
class SlidingPiece < Piece
  include Direction

  def valid_moves_dir(dir, old_pos)
    possible_pos = [old_pos[0] + dir[0], old_pos[1] + dir[1]]
    return [possible_pos] if in_board_and_diff_team?(possible_pos)
    return [] unless board.in_board_and_empty?(possible_pos)

    [possible_pos] + valid_moves_dir(dir, possible_pos)
  end

  def valid_moves
    available = []
    move_dirs.each{ |dir| available.concat(valid_moves_dir(dir, pos)) }
    available.compact
  end
end

class Bishop < SlidingPiece
  def symbol
    symbol = team == :white ? "♗" : "♝"
    symbol.colorize(team)
  end

  def move_dirs
    diagonal
  end

end

class Rook < SlidingPiece
  def symbol
    symbol = team == :white ? "♖" : "♜"
    symbol.colorize(team)
  end

  def move_dirs
    horizontal + vertical
  end
end

class Queen < SlidingPiece
  def symbol
    symbol = team == :white ? "♕" : "♛"
    symbol.colorize(team)
  end

  def move_dirs
    horizontal + vertical + diagonal
  end
end
