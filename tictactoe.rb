class Tictactoe
  class InvalidMove < StandardError
  end
  class GameOver < StandardError
  end

  def initialize(messenger = IO.new(0))
    @board  = [[nil,nil,nil],
               [nil,nil,nil],
               [nil,nil,nil]]
    @players = [:X, :O].cycle
    @messenger = messenger
    get_next_player
  end

  def left_diagonal
    [[0,0],[1,1],[2,2]]
  end

  def right_diagonal
    [[2,0],[1,1],[0,2]]
  end

  def get_next_player
    @current_player = @players.next 
  end

  def print_board
    @messenger.puts @board.map { |row| row.map { |e| e || " " }.join("|") }.join("\n")
  end

  def try_move
    begin
      cell_contents = @board.fetch(@row).fetch(@col)
    rescue IndexError
      @messenger.puts "Out of bounds, try another position"
      raise InvalidMove
    end
    
    if cell_contents
      @messenger.puts "Cell occupied, try another position"
      raise InvalidMove
    end
    @board[@row][@col] = @current_player
  end

  def display_prompt
    print_board
    @messenger.print "\nPlayer #{@current_player}>> "
  end

  def play(input)
    @row, @col = input.split.map { |e| e.to_i }
    @messenger.puts
    try_move
  rescue InvalidMove
  else
    exit_if_win
    exit_if_draw
    get_next_player
  end

  def play_loop
    display_prompt
    play gets
    play_loop
  rescue GameOver
  end

  def wining_line?(line)
    line.all? { |row,col| @board[row][col] == @current_player }
  end

  def relevant_lines
    lines = []

    [left_diagonal, right_diagonal].each do |line|
      lines << line if line.include?([@row,@col])
    end

    lines << (0..2).map { |c1| [@row, c1] }
    lines << (0..2).map { |r1| [r1, @col] }
  end

  def exit_if_win
    if relevant_lines.any?{|line| wining_line?(line)}
      @messenger.puts "#{@current_player} wins!"
      raise GameOver
    end
  end

  def exit_if_draw
    if @board.flatten.compact.length == 9
      @messenger.puts "It's a draw!"
      raise GameOver
    end
  end
end
