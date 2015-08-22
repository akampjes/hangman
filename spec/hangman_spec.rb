require_relative '../hangman'

RSpec.describe HangMan do
  subject { HangMan.new('hang') }

  context "lose a game" do
    before do
      ['a','b','c','d','e','f','g','h','i','j','k','l','m'].each do |letter|
        subject.play_turn letter
      end
    end

    it "is lost" do
      expect(subject.lost?).to be true
    end

    it "becomes finished when lost" do
      allow(subject).to receive(:lost?) { true }
      expect(subject.finished?).to be true
    end

    it "is lost when no turns left" do
      allow(subject).to receive(:remaining_turns) { 0 }
      expect(subject.lost?).to be true
    end
  end

  context "win a game" do
    before do
      ['h','a','n','g'].each do |letter|
        subject.play_turn letter
      end
    end

    it "is won" do
      expect(subject.won?).to be true
    end

    it "becomes finished when won" do
      allow(subject).to receive(:won?) { true }
      expect(subject.finished?).to be true
    end
  end

  context "during a game" do
    it "starts unfinished" do
      expect(subject.finished?).to be false
    end

    it "has word progress" do
      subject.play_turn 'h'
      subject.play_turn 'n'
      expect(subject.word_progress).to eq 'h_n_'
    end

    it "tracks tried letters" do
      subject.play_turn 'x'
      expect(subject.tried_letters).to include 'x'
    end

    describe "#remaining_turns" do
      it "default to 8 turns" do
        expect(subject.remaining_turns).to eq 8
      end

      it "has configurable turns" do
        hangman = HangMan.new('hang', turns: 10)
        expect(hangman.remaining_turns).to eq 10
      end

      it "decreases count on incorrect inputs" do
        subject.play_turn 'q'
        subject.play_turn 'z'
        expect(subject.remaining_turns).to eq 6
      end
    end

    context "exceptional input cases" do
      it "excepts on non alpha letters" do
        expect { subject.play_turn 5 }.to raise_error('Not a valid alphabetical letter :(')
      end

      it "excepts repeated letters" do
        subject.play_turn 'a'
        expect { subject.play_turn 'a' }.to raise_error("You've tried that already silly :P")
      end
    end
  end
end
