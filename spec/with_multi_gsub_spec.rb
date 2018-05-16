require "rnr/with_multi_gsub"

RSpec.describe "RNR::WithMultiGsub" do
  subject { RNR::WithMultiGsub.new(word) }

  describe "string methods" do
    context "if decorated object is string \"example\"" do
      let(:word) { "example" }
      it "is still \"example\"" do
        expect(subject.to_str).to eq "example"
      end
      
      it "is still can be reversed" do
        expect(subject.reverse).to eq "example".reverse
      end
      
      it "is still can be capitalized" do
        expect(subject.capitalize).to eq "example".capitalize
      end
    end
    
    context "if word is \"example file\"" do
      let(:word) { "example file" }
      it "is still \"example file\"" do
        expect(subject.to_str).to eq "example file"
      end
      
      it "is has length" do
        expect(subject.length).to eq "example file".length
      end
      
      it "is still can be upcased" do
        expect(subject.upcase).to eq "example file".upcase
      end
    end  
  end
  
  describe "#multi_gsub" do
    context "if word is \"example\"" do
      let(:word) { "example" }
      context "replace \"a\" with \"o\"" do
        let(:replacements) { [ {"from" => /a/, "to" => "o"} ] }
        it "returns a string-like object" do
          expect(subject.multi_gsub(replacements)).to respond_to(:to_str)
        end

        it "returns a different object than itself" do
          expect(subject.multi_gsub(replacements)).to_not be subject
        end

        it "returns a different object than the decorated one" do
          expect(subject.multi_gsub(replacements)).to_not be word
        end

        it "has returns an \"exomple\" word" do
          expect(subject.multi_gsub(replacements).to_str).to eq "exomple"
        end      
      end
      
      context "if replacements is empty" do
        let(:replacements) { [] }
        it "returns a string-like object" do
          expect(subject.multi_gsub(replacements)).to respond_to(:to_str)
        end

        it "returns a different object than itself" do
          expect(subject.multi_gsub(replacements)).to_not be subject
        end

        it "returns a different object than the decorated one" do
          expect(subject.multi_gsub(replacements)).to_not be word
        end

        it "has returns the unchanged word" do
          expect(subject.multi_gsub(replacements).to_str).to eq "example"
        end      
      end

      context "if replacements swap \"a\" with \"e\"" do
        let(:replacements) { [ {"from" => /a/, "to" => "e"},
                               {"from" => /e/, "to" => "a"}
                             ] }
        it "returns a string-like object" do
          expect(subject.multi_gsub(replacements)).to respond_to(:to_str)
        end

        it "returns a different object than itself" do
          expect(subject.multi_gsub(replacements)).to_not be subject
        end

        it "returns a different object than the decorated one" do
          expect(subject.multi_gsub(replacements)).to_not be word
        end

        it "has returns an \"axempla\" word" do
          expect(subject.multi_gsub(replacements).to_str).to eq "axempla"
        end      
      end

    end
  end
end
