require_relative 'hangman'
require_relative 'hangman_view'
require_relative 'random_word'

def get_letter
  STDIN.gets.to_s[0]
end

random_word = RandomWord.new('words.txt').get_word
hangman = HangMan.new(random_word)

HangManView.display_hangman(hangman)
while !hangman.finished?
  begin
    hangman.play_turn(get_letter)
  rescue HangMan::InvalidLetterError => e
    puts "Not a valid alphabetical Letter :("
  rescue HangMan::AlreadyUsedLetterError => e
    puts "You've already tried that letter silly :P"
  end
  HangManView.display_hangman(hangman)
end
