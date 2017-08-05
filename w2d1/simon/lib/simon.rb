# Had to look into the solution to see how to pause. Look into how exactly
# commands like System and Sleep work. Presumably, 'system' could be intensely
# dangerous to someone wanting to be malicious. Should we really use it that
# often

class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    until @game_over == true
      take_turn
    end
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    if @game_over == false
       @sequence_length += 1
       round_success_message
    end
  end

  def show_sequence
    add_random_color
    @seq.each do |color|
      puts color
      sleep 0.5
    end
  end

  def require_sequence
    system("clear")
    puts("Put the sequence: ")
    @seq.each do |color|
      sequence = gets.chomp
      unless @seq[0] == sequence
        @game_over = true
        break
      end
    end
  end

  def add_random_color
    @seq << COLORS.shuffle[0]
  end

  def round_success_message
    puts("Good work! But can you manage this...")
  end

  def game_over_message
    puts("You lose! Try again. :)")
  end

  def reset_game
    @game_over = false
    @sequence_length = 1
    @seq = []
  end

end
