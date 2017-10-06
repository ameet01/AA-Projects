require_relative 'player.rb'

class Game
  attr_accessor :fragment, :current_player, :dictionary

  def initialize(*args)
    @players = []
    args.each do |i|
      @players << Player.new(i)
    end
    @fragment = ""
    @dictionary = get_dictionary
    @current_player = @players[0]
  end

  def get_dictionary
    File.readlines("dictionary.txt")
  end

  def next_player!
    temp = @current_player
    @current_player = @players[(@players.index(@current_player) + 1) % @players.length]
    @previous_player = temp
  end

  def take_turn(player)
    puts "#{player.name}: Enter a letter"
    letter = gets.chomp.downcase
    if valid_play?(letter)
      @fragment += letter
      if is_word?(@fragment)
        puts ''
        puts "Word found! The word was #{@fragment}"
        @fragment = ""
        give_ghost_letter
        score
        @players.each do |i|
          if i.ghost == "GHOST"
            puts ''
            puts "#{i.name} has been eliminated. Goodbye!"
            @players.delete(i)
            @current_player = @players[0]
          end
        end
      end
      next_player!
    else
      puts "Invalid move. Please try again."
    end
  end

  # For AiPlayer
  # def find_moves
  #   losing_moves = []
  #   winning_moves = []
  #
  #   ('a'..'z').each do |i|
  #     word = @fragment + i
  #     if is_word?(word)
  #       losing_moves << i
  #     else
  #       array = @dictionary.select {|i| i.start_with(word) }
  #       array.map! {|i| i[word.length...i.length] }
  #       if array.all? {|i| i.length <= (@players.length - 1)}
  #         winning_moves << i
  #       end
  #     end
  #   end
  # end

  def score
    puts "\nScore:"
    @players.each do |i|
      puts "#{i.name} [#{i.ghost}]"
    end
  end

  def give_ghost_letter
    if @current_player.ghost.empty? == true
      @current_player.ghost += "G"
    elsif @current_player.ghost.length == 1
      @current_player.ghost += "H"
    elsif @current_player.ghost.length == 2
      @current_player.ghost += "O"
    elsif @current_player.ghost.length == 3
      @current_player.ghost += "S"
    elsif @current_player.ghost.length == 4
      @current_player.ghost += "T"
    end
  end

  def is_word?(string)
    @dictionary.include?(string + "\n")
  end

  def valid_play?(string)
    return false if string == ""
    return false if !string.is_a?(String)
    check = @fragment + string
    @dictionary.any? { |i| i.start_with?(check) }
  end

  def display_fragments
    puts "\n\n-----"
    puts @fragment
    puts "-----"
  end

  def run
    puts "Welcome to Ghost! Please enjoy yourself."
    puts ''
    until @players.length == 1
      take_turn(@current_player)
      display_fragments
    end
    puts @players[0].name + ": is the winner!"
  end
end



if __FILE__ == $PROGRAM_NAME
  game = Game.new("Kevin", "Ameet", "JimBob", 'Michael')
  game.run
end
