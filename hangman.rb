class HangMan
  def initialize(word, turns: 8)
    @word = word
    @word_progress = '_' * @word.length
    @tried_letters = []
    @turns = turns

    print_status
  end

  def play_turn(letter)
    unless finished?
      try_letter(letter)

      print_status
    end
  end

  def status
    # I don't really like this
    play_status = case
                  when won?
                    :won
                  when lost?
                    :lost
                  else
                    :playing
                  end

    # Otherwise like this
    #case
    #when won?
    #  play_status = :won
    #when lost?
    #  play_status = :lost
    #else
    #  play_status = :playing
    #end

    {
      word: @word,
      word_progress: @word_progress,
      tried_letters: @tried_letters,
      remaining_turns: remaining_turns,
      play_status: play_status,
    }
  end

  def print_status
    if won?
      puts "Yus, #{@word}!"
      puts 'You survive to play again another day'

      false
    elsif lost?
      puts 'Gahh choke die'

      false
    else
      puts "#{remaining_turns} turns left"
      puts @word_progress
      puts "Tried #{@tried_letters.join(', ')}" if @tried_letters.length > 0

      true
    end
  end

  private

  def validate_letter(letter)
    unless letter =~ /[[:alpha:]]/
      # Maybe raise an exception on this?
      puts 'Not a valid alphabetical letter :('
      return false
    end

    if @word_progress.include?(letter) || @tried_letters.include?(letter)
      puts "You've tried that already silly :P"
      return false
    end

    true
  end

  def try_letter(letter)
    return unless validate_letter(letter)

    correct_guess = false
    # Add letter to word_progress or to tried_letters
    @word.chars.each_with_index do |char, i|
      if char == letter
        @word_progress[i] = letter
        correct_guess = true
      end
    end

    @tried_letters << letter unless correct_guess
  end

  def finished?
    won? || lost?
  end

  def won?
    !@word_progress.include?('_')
  end

  def lost?
    remaining_turns <= 0
  end

  def remaining_turns
    @turns - @tried_letters.length
  end
end
