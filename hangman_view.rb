class HangManView
  def self.display_hangman(hangman)
    if hangman.won?
      puts "Yus, #{hangman.won?}!"
      puts 'You survive to play again another day'
    elsif hangman.lost?
      puts 'Gahh choke die'
    else
      puts "#{hangman.remaining_turns} turns left"
      puts hangman.word_progress
      puts "Tried #{hangman.tried_letters.join(', ')}" if hangman.tried_letters.length > 0
    end
  end
end
