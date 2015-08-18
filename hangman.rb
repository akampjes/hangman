class HangMan
  require_relative 'random_word'

  attr_accessor :word, :word_progress, :tried_letters

  def initialize(turns: 8)
    random_word = RandomWord.new('words.txt')
    self.word = random_word.get_word
    self.word_progress = '_' * self.word.length
    self.tried_letters = []
    @turns = turns

    print_status
  end

  def play_turn(letter)
    unless game_finished?
      try_letter(letter)

      print_status
    end
  end

  def print_status
    if won?
      puts "Yus, #{self.word}!"
      puts 'You survive to play again another day'

      false
    elsif lost?
      puts 'Gahh choke die'

      false
    else
      puts "#{@turns - self.tried_letters.length} turns left"
      puts self.word_progress
      puts "Tried #{self.tried_letters.join(', ')}" if self.tried_letters.length > 0

      true
    end
  end

  private

  def validate_letter(letter)
    unless letter =~ /[[:alpha:]]/
      puts 'Not a valid alphabetical letter :('
      return false
    end

    if self.word_progress.include?(letter) || self.tried_letters.include?(letter)
      puts "You've tried that already silly :P"
      return false
    end

    true
  end

  def try_letter(letter)
    return unless validate_letter(letter)

    correct_guess = false
    # Add letter to word_progress or to tried_letters
    self.word.chars.each_with_index do |char, i|
      if char == letter
        self.word_progress[i] = letter
        correct_guess = true
      end
    end

    self.tried_letters << letter unless correct_guess
  end

  def game_finished?
    !((@turns - self.tried_letters.length > 0) && self.word_progress.include?('_'))
  end

  def won?
    !self.word_progress.include?('_')
  end

  def lost?
    @turns - self.tried_letters.length <= 0
  end
end
