require "rnr/filtered_entries"
require "rnr/existing_entries"
require "rnr/existing_entry"
require "rnr/filter"
require 'fileutils'

RSpec.describe "RNR::FilteredEntries" do
  subject { RNR::FilteredEntries.new(existing_entries, filter) }
  let(:existing_entries) { RNR::ExistingEntries.new(path) }
  let(:filter) { RNR::Filter.new(reg_expressions) }
  let(:path) { dir }
  let(:dir) { "temp_dir/sub_dir" }
  
  before(:example) do
    Dir.mkdir("temp_dir")
    File.open("temp_dir/file1.example.avi", "w"){}
    File.open("temp_dir/file2.example.wmv", "w"){}
    Dir.mkdir("temp_dir/sub_dir")
    File.open("temp_dir/sub_dir/file3.example.bmp", "w"){}
    File.open("temp_dir/sub_dir/file4.example.jpg", "w"){}
    File.open("temp_dir/sub_dir/file5.example.gif", "w"){}
    File.open("temp_dir/sub_dir/file6.example.gif", "w"){}
    File.open("temp_dir/sub_dir/file7.example.png", "w"){}
    Dir.mkdir("temp_dir/sub_dir/empty_dir")
  end

  after(:example) do
    FileUtils.rm_r("temp_dir")
  end

  context "5 graphical file and 1 directory for given path" do
    context "filter is empty" do
      let(:reg_expressions) { [ ] }
      it "returns no entries" do
        expect(subject.all).to eq []
      end
    end

    context "filter passes everything" do
      let(:reg_expressions) { [ /.*/ ] }
      it "returns every entry" do
        expect(subject.all.map {|e| e.name})
          .to contain_exactly(
                "file3.example.bmp",
                "file4.example.jpg",
                "file5.example.gif",
                "file6.example.gif",
                "file7.example.png",
                "empty_dir"
              )
      end
    end

    context "filter passes png and bmp" do
      let(:reg_expressions) { [ /\.png$/i, /\.bmp$/i ] }
      it "returns png and bmp" do
        expect(subject.all.map {|e| e.name})
          .to contain_exactly(
                "file3.example.bmp",
                "file7.example.png",
              )
      end

      it "returns two ExistingEntries" do
        expect(subject.all.map {|e| e.class})
          .to eq [ RNR::ExistingEntry,
                   RNR::ExistingEntry
                 ]
      end
    end
  end
end

