# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyTetris < Tetris
  # your enhancements here
  def set_board
	 @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

  def key_bindings
	  super
	  @root.bind('u' , proc {@board.rotate_clockwise;@board.rotate_clockwise})
	  @root.bind('c' , proc {@board.cheating = true})
  end
  
end

class MyPiece < Piece
  # The constant All_My_Pieces should be declared here
  All_My_Pieces = All_Pieces + [rotations([[0, 0], [1, 0], [0, 1], [1, 1], [2, 1]]),
                                         [[[-2, 0], [-1, 0], [0, 0], [1, 0], [2, 0]],
                                         [[0, -2], [0, -1], [0, 0], [0, 1], [0, 2]]],
                               rotations([[0, 0], [0, 1], [1, 0]])]

  Cheat_Piece = [[[0, 0]]]

  def MyPiece.next_piece (board)
	 if board.cheating 
	    board.cheating = false
	    if board.score >= 100
	   	 board.score = board.score - 100
          MyPiece.new(Cheat_Piece, board)
	    else
	   	 MyPiece.new(All_My_Pieces.sample, board)
	    end
	 else
	    MyPiece.new(All_My_Pieces.sample, board)
	 end
  end

  attr_accessor :all_rotations
end

class MyBoard < Board
  # your enhancements here
  def initialize (game)
	  super
	  @current_block = MyPiece.next_piece(self)
	  @cheating = false
  end

  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
	 last = current_block.all_rotations[0].length - 1
    (0..last).each{|index| 
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
      @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end

  def next_piece
    @current_block = MyPiece.next_piece(self)
    @current_pos = nil
  end
  
  attr_accessor :cheating
  attr_accessor :score
  attr_accessor :current_block
end
