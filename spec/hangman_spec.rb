require_relative '../hangman'

RSpec.describe HangMan do

  describe "#get_letter" do
    it "should read the first letter from STDIN" do
      allow(STDIN).to receive(:gets) {'joe'}
      expect(subject.get_letter).to eq 'j'
    end

    it "should remove newlines" do
      allow(STDIN).to receive(:gets) {"\n"}
      expect(subject.get_letter).to eq nil
    end
  end

  describe "#validate_letter" do
    it "valid letter" do
      expect(subject.validate_letter('a')).to be true
    end

    it "invalid letter" do
      expect(subject.validate_letter('-')).to be false
    end

    it "should not allow the same letters tried" do
      allow(subject).to receive(:tried_letters) {['a','b','c','d','e','f','g','h']}

      expect(subject.validate_letter('a')).to be false
    end

    it "should not allow the same letters tried word_progress" do
      allow(subject).to receive(:word_progress) {'abcd'}

      expect(subject.validate_letter('a')).to be false
    end
  end

  describe "#game_unfinished?" do
    it "should be unfinished to start" do
      expect(subject.game_finished?).to be false
    end

    it "should be finished when turns 8 failures" do
      allow(subject).to receive(:tried_letters) {['a','b','c','d','e','f','g','h']}

      expect(subject.game_finished?).to be true
    end

    it "should be finished on complete word" do
      allow(subject).to receive(:word_progress) {'abcd'}

      expect(subject.game_finished?).to be true
    end
  end

  describe "#check_letter" do

  end
end
