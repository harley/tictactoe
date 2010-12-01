class Tictactoe
  def initialize
    @board  = [[nil,nil,nil],
               [nil,nil,nil],
               [nil,nil,nil]]
    @players = [:X, :O].cycle
  end

  def left_diagonal
    [[0,0],[1,1],[2,2]]
  end

  def right_diagonal
    [[2,0],[1,1],[0,2]]
  end

  def get_next_player
    @players.next 
  end

  def start
    loop do
      current_player = get_next_player
      puts @board.map { |row| row.map { |e| e || " " }.join("|") }.join("\n")
      print "\nPlayer #{current_player}>> "
      row, col = gets.split.map { |e| e.to_i }
      puts

      begin
        cell_contents = @board.fetch(row).fetch(col)
      rescue IndexError
        puts "Out of bounds, try another position"
        next
      end
      
      if cell_contents
        puts "Cell occupied, try another position"
        next
      end

      @board[row][col] = current_player

      lines = []

      [left_diagonal, right_diagonal].each do |line|
        lines << line if line.include?([row,col])
      end

      lines << (0..2).map { |c1| [row, c1] }
      lines << (0..2).map { |r1| [r1, col] }

      win = lines.any? do |line|
        line.all? { |row,col| @board[row][col] == current_player }
      end

      if win
        puts "#{current_player} wins!"
        exit
      end

      if @board.flatten.compact.length == 9
        puts "It's a draw!"
        exit
      end
    end
  end
end
