module Direction

  def diagonal
    [
     [ 1, 1],
     [ 1,-1],
     [-1, 1],
     [-1,-1]
    ]
  end

  def horizontal
    [
     [ 1, 0],
     [-1, 0]
    ]
  end

  def vertical
    [
     [ 0, 1],
     [ 0,-1]
    ]
  end


end
