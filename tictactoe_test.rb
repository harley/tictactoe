require 'test/unit'
require 'tictactoe'
require 'stringio'

class TictactoeTest < Test::Unit::TestCase
  def setup
    @messenger = StringIO.new
    @game = Tictactoe.new(@messenger)
  end

  def test_board_diagonals
    assert_equal(@game.left_diagonal, [[0,0],[1,1],[2,2]]) 
    assert_equal(@game.right_diagonal, [[2,0],[1,1],[0,2]])
  end

  def test_get_next_player
    a = @game.get_next_player
    b = @game.get_next_player
    c = @game.get_next_player
    assert [:X, :O].include? a
    assert [:X, :O].include? b
    assert_equal a,c
  end

  def test_printing_empty_board
    @game.print_board
    empty_board = " | | \n | | \n | | \n"
    assert_equal @messenger.string, empty_board
  end

  def test_out_of_bound_y
    assert !@messenger.string.include?("Out of bounds, try another position")
    @game.play "1 3" 
    assert @messenger.string.include?("Out of bounds, try another position")
  end

  def test_out_of_bound_x
    assert !@messenger.string.include?("Out of bounds, try another position")
    @game.play "3 1" 
    assert @messenger.string.include?("Out of bounds, try another position")
  end

  def test_out_of_bound_both
    assert !@messenger.string.include?("Out of bounds, try another position")
    @game.play "4 4" 
    assert @messenger.string.include?("Out of bounds, try another position")
  end

  def test_cell_overlapped_move
    assert !@messenger.string.include?("Cell occupied")
    @game.play "0 0" 
    @game.play "0 0"
    assert @messenger.string.include?("Cell occupied")
  end

  def test_draw_game
    @game.play "0 0"
    @game.play "0 2"
    @game.play "0 1"
    @game.play "1 0"
    @game.play "1 2"
    @game.play "1 1"
    @game.play "2 0"
    @game.play "2 1"
    assert !@messenger.string.include?("It's a draw")
    assert_raise Tictactoe::GameOver do
      @game.play "2 2"
    end
    assert @messenger.string.include?("It's a draw")
  end

  def test_winning_game
    @game.play "0 0"
    @game.play "0 2"
    @game.play "0 1"
    @game.play "1 2"
    @game.play "1 0"
    @game.play "1 1"
    assert !@messenger.string.include?("wins!")
    assert_raise Tictactoe::GameOver do
      @game.play "2 0"
    end
    assert @messenger.string.include?("wins!")
  end
  
end
