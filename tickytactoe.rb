class TicTacToe
    def initialize
      @board = Array.new(3) { Array.new(3, ' ') }
      @current_player = 'X'
    end
  
    def print_board
      puts "  0 1 2"
      @board.each_with_index do |row, i|
        puts "#{i} #{row.join('|')}"
        puts "  -----"
      end
    end
  
    def make_move(row, col)
      if @board[row][col] == ' '
        @board[row][col] = @current_player
        switch_player
        true
      else
        puts "Invalid move. Try again."
        false
      end
    end
  
    def switch_player
      @current_player = (@current_player == 'X') ? 'O' : 'X'
    end
  
    def check_winner
      # Check rows, columns, and diagonals
      (0..2).each do |i|
        return @board[i][0] if @board[i][0] == @board[i][1] && @board[i][1] == @board[i][2] && @board[i][0] != ' '
        return @board[0][i] if @board[0][i] == @board[1][i] && @board[1][i] == @board[2][i] && @board[0][i] != ' '
      end
  
      return @board[0][0] if @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2] && @board[0][0] != ' '
      return @board[0][2] if @board[0][2] == @board[1][1] && @board[1][1] == @board[2][0] && @board[0][2] != ' '
  
      nil
    end
  
    def board_full?
      @board.all? { |row| row.none? { |cell| cell == ' ' } }
    end
  
    def game_over?
      check_winner || board_full?
    end
  end
  
  # Main game loop
  game = TicTacToe.new
  
  until game.game_over?
    game.print_board
    puts "#{game.current_player}'s turn. Enter row and column (e.g., 0 1):"
    row, col = gets.chomp.split.map(&:to_i)
  
    if row.between?(0, 2) && col.between?(0, 2)
      if game.make_move(row, col)
        winner = game.check_winner
        break if winner || game.board_full?
      else
        next
      end
    else
      puts "Invalid input. Row and column must be between 0 and 2. Try again."
    end
  end
  
  game.print_board
  
  if game.check_winner
    puts "#{game.check_winner} wins!"
  else
    puts "It's a tie!"
  end
  