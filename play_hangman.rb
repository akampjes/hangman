require_relative 'hangman'
require_relative 'hangman_view'
require_relative 'random_word'

def get_letter
  input = STDIN.gets.to_s.chomp
  input[0]
end

random_word = RandomWord.new('words.txt').get_word
hangman = HangMan.new(random_word)

HangManView.display_hangman(hangman)
while !hangman.finished?
  begin
    hangman.play_turn(get_letter)
  rescue => e
    puts e
  end
  HangManView.display_hangman(hangman)
end
