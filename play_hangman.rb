require_relative 'hangman'
require_relative 'random_word'

def get_letter
  input = STDIN.gets.to_s.chomp
  input[0]
end

random_word = RandomWord.new('words.txt').get_word
hangman = HangMan.new(random_word)

while hangman.status[:play_status] == :playing
  hangman.play_turn(get_letter)
end
