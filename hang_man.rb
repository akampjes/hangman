class HangMan
  class InvalidLetterError < StandardError ; end
  class AlreadyUsedLetterError < StandardError ; end

  attr_reader :word, :tried_letters

  def initialize(word, turns: 8)
    @turns = turns
    @word = word
    @tried_letters = []
  end

  def play_turn(letter)
    try_letter(letter) unless finished?
  end

  def won?
    !word_progress.include?('_')
  end

  def lost?
    remaining_turns <= 0
  end

  def finished?
    won? || lost?
  end

  def remaining_turns
    @turns - tried_letters.length
  end

  def word_progress
    unless tried_letters.empty?
      # Replace all the untried letters with underscores
      word.gsub(/[^#{tried_letters.join}]/,'_')
    else
      '_' * word.length
    end
  end

  private

  def try_letter(letter)
    fail InvalidLetterError unless letter =~ /[[:alpha:]]/

    unless tried_letters.include?(letter)
      tried_letters << letter
    else
      fail AlreadyUsedLetterError
    end
  end
end
