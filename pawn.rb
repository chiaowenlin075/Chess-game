class Pawn < Piece
attr_accessor :turn

  def initialize(pos, board, team)
    super(pos, board, team)
    @turn = 1
  end

  def valid_moves
    available = move_dirs.select{ |dir| board.in_board_and_empty?(new_pos(dir)) }
    available_pos = available.map{ |dir| new_pos(dir) }
    available_pos.concat(eat_opponent)
  end

  private

  def move_dirs # just move
    @turn == 1 ? [[head_dir, 0], [head_dir*2, 0]] : [[head_dir, 0]]
  end

  def eat_opponent # when eat opponent
    eat_dirs = [[head_dir, 1], [head_dir, -1]]
    eat_dirs.select do |dir|
      possible_pos = new_pos(dir)
      in_board_and_diff_team?(possible_pos)
    end.map{ |dir| new_pos(dir) }
  end

  def head_dir # decide heading dir by team
    team == :white ? 1 : -1
  end

end
