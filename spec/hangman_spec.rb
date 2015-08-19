require_relative '../hangman'

RSpec.describe HangMan do
  subject { HangMan.new('hang') }

  context "playing a game" do
    it "should start" do
      expect(subject.finished?).to be false
    end

    it "should be winnable" do
      ['h','a','n','g'].each do |letter|
        subject.play_turn letter
      end

      expect(subject.won?).to be true
    end

    it "should be losable" do
      ['a','b','c','d','e','f','g','h','i','j','k','l','m'].each do |letter|
        subject.play_turn letter
      end

      expect(subject.lost?).to be true
    end

    it "should have word progress" do
      subject.play_turn 'h'
      subject.play_turn 'n'

      expect(subject.word_progress).to eq 'h_n_'
    end

    it "should have tried letters" do
      subject.play_turn 'x'

      expect(subject.tried_letters).to include 'x'
    end

    it "should except on non alpha letters" do
      expect { subject.play_turn 5 }.to raise_error('Not a valid alphabetical letter :(')
    end

    it "should except repeated letters" do
      subject.play_turn 'a'
      expect { subject.play_turn 'a' }.to raise_error("You've tried that already silly :P")
    end
  end

  describe "#finished?" do
    it "should start unfinished" do
      expect(subject.finished?).to be false
    end

    it "should become finished when won" do
      allow(subject).to receive(:won?) { true }

      expect(subject.finished?).to be true
    end

    it "should become finished when lost" do
      allow(subject).to receive(:lost?) { true }

      expect(subject.finished?).to be true
    end
  end

  describe "#lost?" do
    it "should be lost when no turns left" do
      allow(subject).to receive(:remaining_turns) { 0 }

      expect(subject.lost?).to be true
    end
  end

  describe "#remaining_turns" do
    it "should should default to 8" do
      expect(subject.remaining_turns).to eq 8
    end

    it "should be initializable to N turns" do
      hangman = HangMan.new('hang', turns: 10)
      
      expect(hangman.remaining_turns).to eq 10
    end

    it "should decrease on incorrect inputs" do
      subject.play_turn 'q'
      subject.play_turn 'z'

      expect(subject.remaining_turns).to eq 6
    end
  end
end
