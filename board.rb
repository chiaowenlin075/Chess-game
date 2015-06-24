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

  def move(old_pos, new_pos) # move one single piece to new position and update info
    raise NotValidMoveError unless in_board?(old_pos) &&
                                    !empty?(old_pos) &&
                                    self[old_pos].valid_moves.include?(new_pos)
    raise UnsafeMoveError unless self[old_pos].safe_moves.incude?(new_pos)

    self[new_pos], self[old_pos] = self[old_pos], nil
    self[new_pos].pos = new_pos
    self[new_pos].turn += 1 if self[new_pos].class == Pawn
  end

  def move!(old_pos, new_pos) # move without checking safety
    raise NotValidMoveError unless in_board?(old_pos) &&
                                    !empty?(old_pos) &&
                                    self[old_pos].valid_moves.include?(new_pos)
    self[new_pos], self[old_pos] = self[old_pos], nil
    self[new_pos].pos = new_pos
    self[new_pos].turn += 1 if self[new_pos].class == Pawn
  end

  def pieces
    grid.flatten.compact
  end

  def king_pos(team)
    pieces.select { |piece| piece.class == King && piece.team == team }.first.pos
  end

  def same_team_pieces(team)
    pieces.select { |piece| piece.team == team }
  end

  def all_valid_moves_of_team(team)
    all_valid_moves = []
    same_team_pieces(team).each do |piece|
      all_valid_moves.concat(piece.valid_moves)
    end
    all_valid_moves.uniq
  end

  def in_check?(team)
    oppo_team = team == :white ? :black : :white
    all_valid_moves_of_team(oppo_team).include?(king_pos(team))
  end

  def checkmate?(team)
    in_check?(team) && same_team_pieces(team).all? { |piece| piece.safe_moves.empty? }
  end

  def empty?(pos)
    self[pos] == nil
  end

  def in_board?(pos)
    pos.all? { |index| index.between?(0, GRIDSIZE - 1) }
  end

  def in_board_and_empty?(pos)
    in_board?(pos) && empty?(pos)
  end

  def deep_dup
    dup_board = Board.new(false)
    pieces.each do |piece|
      dup_board[piece.pos] = piece.class.new(piece.pos.dup, dup_board, piece.team)
      dup_board[piece.pos].turn = piece.turn if piece.class == Pawn
    end
    dup_board
  end
end

class NotValidMoveError < StandardError
end

class UnsafeMoveError < StandardError
end
