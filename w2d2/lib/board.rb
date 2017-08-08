class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1, @name2 = name1, name2
    @cups = Array.new(14) {Array.new}
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_with_index do |cup, idx|
      if idx == 6 || idx == 13
         next
      end
      cup << :stone
      cup << :stone
      cup << :stone
      cup << :stone
    end
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if start_pos > 12 || start_pos < 1
    raise "Invalid starting cup" if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos].count
    @cups[start_pos] = []
    current = start_pos
    until stones == 0
      current += 1
      current == 0 if current > 13

      next if current == 13 && current_player_name == @name1
      next if current == 6 && current_player_name == @name2

      @cups[current] << :stone
      stones -= 1
    end
    render
    next_turn(current)

  end

  def next_turn(ending_cup_idx)
    # helper method to determine what #make_move returns
    if ending_cup_idx == 6 || ending_cup_idx == 13
       return :prompt
    elsif @cups[ending_cup_idx].count == 1 # Therefore, it was empty before then
       return :switch
    else
      ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    side_one, side_two = false, false
    @cups[0..5].each do |check|
      unless check.empty?
        break
      else
        side_one = true
      end
    end

    @cups[7..12].each do |check|
      unless check.empty?
        break
      else
        side_two = true
      end
    end

  side_one || side_two
  end

  def winner
    if @cups[6].count > @cups[13].count
       return @name1
    elsif @cups[13].count > @cups[6].count
       return @name2
    else
       return :draw
    end
  end
end
