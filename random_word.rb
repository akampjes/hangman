class RandomWord
  require 'securerandom'

  def initialize(wordfile)
    @wordfile = wordfile
  end

  def get_word
    lines = File.readlines(@wordfile)
    i = SecureRandom.random_number(lines.length)
    
    lines[i].chomp
  end
end

