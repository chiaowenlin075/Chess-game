# encoding: utf-8
class SteppingPiece < Piece
  include Direction

  def valid_moves
    move_dirs.select{ |dir| available_pos?(new_pos(dir)) }.map{ |dir| new_pos(dir) }
  end

end

class Knight < SteppingPiece
  def symbol
    symbol = team == :white ? "♘" : "♞"
    symbol.colorize(team)
  end

  def move_dirs
    [
     [ 2, 1],
     [ 2,-1],
     [-2, 1],
     [-2,-1],
     [ 1, 2],
     [ 1,-2],
     [-1, 2],
     [-1,-2]
    ]
  end

end

class King < SteppingPiece
  def symbol
    symbol = team == :white ? "♔" : "♚"
    symbol.colorize(team)
  end

  def move_dirs
    vertical + horizontal + diagonal
  end
end
