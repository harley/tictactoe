class Tictactoe
  def initialize(messenger = IO.new(0))
    @board  = [[nil,nil,nil],
               [nil,nil,nil],
               [nil,nil,nil]]
    @players = [:X, :O].cycle
    @messenger = messenger
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

  def get_player_input
    @messenger.print "\nPlayer #{@current_player}>> "
    @row, @col = @messenger.gets.split.map { |e| e.to_i }
    @messenger.puts
    exit unless @col
  end

  def start
    get_next_player
    loop do
      print_board
      get_player_input

      begin
        cell_contents = @board.fetch(@row).fetch(@col)
      rescue IndexError
        @messenger.puts "Out of bounds, try another position"
        next
      end
      
      if cell_contents
        @messenger.puts "Cell occupied, try another position"
        next
      end

      @board[@row][@col] = @current_player

      exit_if_win
      exit_if_draw
      get_next_player
    end
  end

  def exit_if_win
    lines = []

    [left_diagonal, right_diagonal].each do |line|
      lines << line if line.include?([@row,@col])
    end

    lines << (0..2).map { |c1| [@row, c1] }
    lines << (0..2).map { |r1| [r1, @col] }

    win = lines.any? do |line|
      line.all? { |row,col| @board[row][col] == @current_player }
    end

    if win
      @messenger.puts "#{@current_player} wins!"
      exit
    end
  end

  def exit_if_draw
    if @board.flatten.compact.length == 9
      @messenger.puts "It's a draw!"
      exit
    end
  end
end
