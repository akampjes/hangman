# HangMan that I first wrote in my interview

class HangMan
  require 'SecureRandom'

  def initialize
    @lives = 8
    @wrong_letters = []

    all_words = File.new('words.txt').readlines()
    @word = all_words[SecureRandom.random_number(all_words.length)].chomp
    puts "pssst, the word is #{@word}"

    @word_progress = '_' * @word.length
    @won = false
  end

  def play_game
    while @lives > 0 && !@won
      play_turn
    end

    if @won
      puts 'You have won the game 😀'
    else
      puts 'You die painfully 😲'
    end
  end

  def valid_letter?(guess_letter)
    # Check for weird inputs (or no newlines)
    (guess_letter =~ /[[:alpha:]]/) || 
    !@wrong_letters.include?(guess_letter) || 
    !@word_progress.include?(guess_letter)
  end

  def correct_choice?(guess_letter)
    correct_guess = false

    @word.chars.each_with_index do |letter,i|
      if guess_letter == letter
        @word_progress[i] = guess_letter
        correct_guess = true
      end
    end

    correct_guess
  end

  def won_game?
    !(@word_progress.include?('_'))
  end

  def play_turn
    puts @word_progress
    puts @wrong_letters.join(',')
    puts "You have #{@lives} lives left!"

    guess = gets
    # We only allow the first letter of the guess, discard the rest
    guess_letter = guess[0]

    puts 'Not a valid guess char' unless valid_letter?(guess_letter)

    unless correct_choice?(guess_letter)
      @lives -= 1
      @wrong_letters.push guess_letter
    end

    # Have we won the game yet?
    if won_game?
      @won = true
    end
  end
end

HangMan.new.play_game

