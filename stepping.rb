class SteppingPiece < Piece
  include Direction

  def valid_moves
    move_dirs.select{ |dir| available_pos?(new_pos(dir)) }.map{ |dir| new_pos(dir) }
  end

end

class Knight < SteppingPiece

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
  def move_dirs
    vertical + horizontal + diagonal
  end
end
