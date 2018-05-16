require "rnr/filter"

RSpec.describe "RNR::Filter" do
  subject { RNR::Filter.new(reg_expressions) }

  context "for wmv and mp4 files" do
    let(:reg_expressions) {
      [ /\.wmv$/i,
        /\.mp4$/i
      ]
    }
    
    it "recognizes wmv name file" do
      expect(subject.match?("video.Wmv")).to be true
    end
    
    it "recognizes mp4 name file" do
      expect(subject.match?(".mP4")).to be true
    end

    it "doesn't recognize avi name file" do
      expect(subject.match?("video.avi")).to be false
    end

    it "doesn't recognize fake wmv name file" do
      expect(subject.match?("video.wmv.avi")).to be false
    end
  end

  context "if no expressions are given" do
    let(:reg_expressions) { [] }
    it "doesn't recognize wmv name file" do
      expect(subject.match?("video.Wmv")).to be false
    end
    
    it "doesn't recognize mp4 name file" do
      expect(subject.match?(".mP4")).to be false
    end
    
    it "doesn't recognize avi name file" do
      expect(subject.match?("video.avi")).to be false
    end
  end

  context "if search for repeating words" do
    let(:reg_expressions) { [/(...+).*\1/i] }
    it "doesn't recognize wmv name file" do
      expect(subject.match?("video.Wmv")).to be false
    end
    
    it "doesn't recognize mp4 name file" do
      expect(subject.match?(".mP4")).to be false
    end
    
    it "recognizes name file with repeated word" do
      expect(subject.match?("Video.vid")).to be true
    end
  end
end
