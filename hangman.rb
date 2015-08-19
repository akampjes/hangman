class HangMan
  attr_accessor :word, :word_progress, :tried_letters

  def initialize(word, turns: 8)
    self.word = word
    self.word_progress = '_' * self.word.length
    self.tried_letters = []
    @turns = turns
  end

  def play_turn(letter)
    unless finished?
      try_letter(letter)
    end
  end

  def won?
    !self.word_progress.include?('_')
  end

  def lost?
    remaining_turns <= 0
  end

  def finished?
    won? || lost?
  end

  def remaining_turns
    @turns - self.tried_letters.length
  end

  private

  def validate_letter!(letter)
    unless letter =~ /[[:alpha:]]/
      fail 'Not a valid alphabetical letter :('
    end

    if self.word_progress.include?(letter) || self.tried_letters.include?(letter)
      fail "You've tried that already silly :P"
    end

    true
  end

  def try_letter(letter)
    validate_letter!(letter)

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
end
