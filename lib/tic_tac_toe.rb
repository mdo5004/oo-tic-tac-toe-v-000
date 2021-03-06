class TicTacToe
  def initialize
    @board = [" "," "," "," "," "," "," "," "," "]
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, current_player)
    @board[index] = current_player
  end

  def position_taken?(location)
    @board[location] != " " && @board[location] != ""
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn(player = "X")
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    player = current_player
    if valid_move?(index)
      move(index, player)
      display_board
    else
      turn()
    end
  end

  def turn_count
    counter = 0
    @board.each {|space|
      if space == "X" || space == "O"
        counter += 1
      end
      }
      return counter

  end

  def current_player
    counter = turn_count
    turn = counter % 2 == 0 ? "X" : "O"
  end

  def won?
      someone_won = WIN_COMBINATIONS.any? { |combination|
    combination.all? { |i| @board[i] == "X" } || combination.all?{ |i| @board[i] == "O"}
    }

    if someone_won
      how_they_won = WIN_COMBINATIONS.each {|combination|
        if combination.all? { |i| @board[i] == "X" } || combination.all?{ |i| @board[i] == "O"}
          return combination
        end
      }
    end
  end

  def full?
    @board.all? {|i| i == "X" || i == "O"}
  end

  def draw?
     !won? && full?
  end

  def over?
    won? || draw? || full?
  end

  def winner
    winning_combination = won?
    if winning_combination
      return @board[winning_combination[0]]
    end
  end


  def play

    until over?
      player = current_player
      turn(player)
    end

    player_won = winner
    if player_won
      puts "Congratulations #{player_won}!"
    else
      puts "Cat's Game!"
    end

  end



end
