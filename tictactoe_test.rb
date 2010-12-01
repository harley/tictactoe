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
  
end
