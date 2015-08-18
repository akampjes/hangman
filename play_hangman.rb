require_relative 'hangman'

def get_letter
  input = STDIN.gets.to_s.chomp
  input[0]
end

hangman = HangMan.new(turns: 10)

while hangman.play_turn(get_letter) ; end
