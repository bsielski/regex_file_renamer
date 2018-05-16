require "rnr/renamed_entries"
require "rnr/existing_entries"
require "rnr/existing_entry"
require 'fileutils'

RSpec.describe "RNR::RenamedEntries" do
  subject { RNR::RenamedEntries.new(existing_entries, replacements) }
  let(:existing_entries) { RNR::ExistingEntries.new(path) }
  let(:replacements) { [] }
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
    context "replacements is empty" do
      let(:replacements) { [ ] }
      it "returns unchanged entries" do
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

    context "swaps \"e\" with \"a\"" do
      let(:replacements) { [ { "from" => /a/, "to" => "e" },
                             { "from" => /e/, "to" => "a" } ] }
      it "returns modified entries" do
        expect(subject.all.map {|e| e.name})
          .to contain_exactly(
                "fila3.axempla.bmp",
                "fila4.axempla.jpg",
                "fila5.axempla.gif",
                "fila6.axempla.gif",
                "fila7.axempla.png",
                "ampty_dir"
              )
      end
    end

    context "upcase extentions png and bmp" do
      let(:replacements) { [ { "from" => /\.png$/i, "to" => ".PNG" },
                             { "from" => /\.bmp$/i, "to" => ".BMP" } ] }
      it "returns png and bmp" do
        expect(subject.all.map {|e| e.name})
          .to contain_exactly(
                "file3.example.BMP",
                "file4.example.jpg",
                "file5.example.gif",
                "file6.example.gif",
                "file7.example.PNG",
                "empty_dir"
              )
      end

      it "returns ExistingEntries" do
        expect(subject.all.map {|e| e.class})
          .to eq [ RNR::ExistingEntry,
                   RNR::ExistingEntry,
                   RNR::ExistingEntry,
                   RNR::ExistingEntry,
                   RNR::ExistingEntry,
                   RNR::ExistingEntry
                 ]
      end
    end
  end
end

