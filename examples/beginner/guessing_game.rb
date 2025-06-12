#!/usr/bin/env ruby
# Beginner Example: Number Guessing Game
# Demonstrates: Loops, conditionals, random numbers, user input

class NumberGuessingGame
  def initialize(min = 1, max = 100)
    @min = min
    @max = max
    @secret_number = rand(min..max)
    @attempts = 0
    @max_attempts = calculate_max_attempts
  end
  
  def calculate_max_attempts
    # Give players reasonable number of attempts based on range
    Math.log2(@max - @min + 1).ceil + 2
  end
  
  def display_welcome
    puts "="*50
    puts "🎯 Welcome to the Number Guessing Game! 🎯"
    puts "="*50
    puts "I'm thinking of a number between #{@min} and #{@max}"
    puts "You have #{@max_attempts} attempts to guess it!"
    puts "Let's see if you can find it! 🤔"
    puts
  end
  
  def get_user_guess
    loop do
      print "Enter your guess (#{@min}-#{@max}): "
      input = gets.chomp
      
      # Check if input is a valid number
      if input.match?(/^\d+$/)
        guess = input.to_i
        if guess.between?(@min, @max)
          return guess
        else
          puts "⚠️  Please enter a number between #{@min} and #{@max}!"
        end
      else
        puts "⚠️  Please enter a valid number!"
      end
    end
  end
  
  def provide_hint(guess)
    difference = (@secret_number - guess).abs
    
    case difference
    when 0
      "🎉 Exactly right!"
    when 1..5
      guess < @secret_number ? "🔥 Very close! Go higher!" : "🔥 Very close! Go lower!"
    when 6..15
      guess < @secret_number ? "📈 Close! Try higher!" : "📉 Close! Try lower!"
    when 16..30
      guess < @secret_number ? "⬆️  Too low!" : "⬇️  Too high!"
    else
      guess < @secret_number ? "⬆️  Way too low!" : "⬇️  Way too high!"
    end
  end
  
  def play_round
    @attempts += 1
    remaining_attempts = @max_attempts - @attempts
    
    puts "\n--- Attempt #{@attempts}/#{@max_attempts} ---"
    guess = get_user_guess
    
    if guess == @secret_number
      puts "🎊 CONGRATULATIONS! 🎊"
      puts "You found the number #{@secret_number} in #{@attempts} attempts!"
      display_performance_rating
      return true
    else
      hint = provide_hint(guess)
      puts hint
      
      if remaining_attempts > 0
        puts "You have #{remaining_attempts} attempts left."
      else
        puts "💔 Game Over! The number was #{@secret_number}"
        puts "Better luck next time!"
        return true
      end
    end
    
    false
  end
  
  def display_performance_rating
    rating = case @attempts
             when 1
               "🏆 LEGENDARY! First try!"
             when 2..3
               "🥇 EXCELLENT! Amazing skills!"
             when 4..5
               "🥈 GREAT! Well done!"
             when 6..7
               "🥉 GOOD! Nice work!"
             else
               "👍 Not bad! Keep practicing!"
             end
    
    puts rating
  end
  
  def play_again?
    loop do
      print "\nWould you like to play again? (y/n): "
      response = gets.chomp.downcase
      
      case response
      when 'y', 'yes'
        return true
      when 'n', 'no'
        return false
      else
        puts "Please enter 'y' for yes or 'n' for no."
      end
    end
  end
  
  def start_game
    display_welcome
    
    loop do
      game_over = false
      
      until game_over
        game_over = play_round
      end
      
      break unless play_again?
      
      # Reset for new game
      @secret_number = rand(@min..@max)
      @attempts = 0
      puts "\n🔄 Starting new game...\n"
    end
    
    puts "\n👋 Thanks for playing! See you next time!"
  end
end

# Game configuration and startup
if __FILE__ == $0
  puts "Choose difficulty level:"
  puts "1. Easy (1-50, more attempts)"
  puts "2. Medium (1-100, normal attempts)"
  puts "3. Hard (1-200, fewer attempts)"
  print "Select level (1-3): "
  
  level = gets.chomp.to_i
  
  game = case level
         when 1
           NumberGuessingGame.new(1, 50)
         when 2
           NumberGuessingGame.new(1, 100)
         when 3
           NumberGuessingGame.new(1, 200)
         else
           puts "Invalid choice, defaulting to Medium"
           NumberGuessingGame.new(1, 100)
         end
  
  game.start_game
end
