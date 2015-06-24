class Board
  GRIDSIZE = 8

  attr_accessor :grid
  def initialize(need_board = true)
    @grid = Array.new(GRIDSIZE) { Array.new(GRIDSIZE) }
    @grid = make_grid if need_board
  end

  def make_grid
    pieces = [Bishop, Knight, Rook, Queen, King, Rook, Knight, Bishop]

    [0, 7].each do |row|
      team = row == 0 ? :white : :black # start from 0 is team white
      pawn_row = row == 0 ? 1 : 6
      pieces.each_with_index do |piece, col|
        self[[row,col]] = piece.new([row,col], self, team)
        self[[pawn_row,col]] = Pawn.new([pawn_row,col], self, team)
      end
    end
    grid
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []= (pos, piece)
    row, col = pos
    self.grid[row][col] = piece
  end

  def move_pieces(old_pos, new_pos)
    self[new_pos], self[old_pos] = self[old_pos], nil
    self[new_pos].pos = new_pos
  end

  def pieces
    grid.compact
  end

  def empty?(pos)
    self[pos] == nil
  end

  def in_board?(pos)
    pos.all? { |index| index.between?(0, GRIDSIZE - 1) }
  end

  def in_board_and_empty?(pos)
    empty?(pos) && in_board?(pos)
  end

end
