require 'test/unit'
require 'tictactoe'

class TictactoeTest < Test::Unit::TestCase
  def setup
    @game = Tictactoe.new  
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
  
end
