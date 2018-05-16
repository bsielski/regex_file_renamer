require "rnr/existing_entries"
require "rnr/existing_entry"
require 'fileutils'

RSpec.describe "RNR::ExistingEntries" do
  subject { RNR::ExistingEntries.new(path) }
  let(:path) { dir }
  let(:dir) do
    # Dir.mkdir("temp_dir")
    # File.open("temp_dir/file1.example", "w"){}
    # File.open("temp_dir/file2.example", "w"){}
    # Dir.mkdir("temp_dir/sub_dir")
    # File.open("temp_dir/sub_dir/file3.example", "w"){}
    # File.open("temp_dir/sub_dir/file4.example", "w"){}
    # File.open("temp_dir/sub_dir/file5.example", "w"){}
    # File.open("temp_dir/sub_dir/file6.example", "w"){}
    # Dir.mkdir("temp_dir/sub_dir/empty_dir")
    "temp_dir"
  end
  
  before(:example) do
    Dir.mkdir("temp_dir")
    File.open("temp_dir/file1.example", "w"){}
    File.open("temp_dir/file2.example", "w"){}
    Dir.mkdir("temp_dir/sub_dir")
    File.open("temp_dir/sub_dir/file3.example", "w"){}
    File.open("temp_dir/sub_dir/file4.example", "w"){}
    File.open("temp_dir/sub_dir/file5.example", "w"){}
    File.open("temp_dir/sub_dir/file6.example", "w"){}
    Dir.mkdir("temp_dir/sub_dir/empty_dir")
  end

  after(:example) do
    FileUtils.rm_r("temp_dir")
  end

  context "if dir path is incorrect" do
    let(:dir) { "incorrect_temp_dir" }
    describe "#all" do
      it "raises an exception" do
        expect{subject.all}.to raise_exception Errno::ENOENT
      end
    end
  end

  context "if directory is empty" do
    let(:dir) { "temp_dir/sub_dir/empty_dir" }
    describe "#all" do
      it "returns the empty array" do
        expect(subject.all).to eq []
      end
    end
  end
  
  context "if path is to a file instead of a directory" do
    let(:path) { "temp_dir/file1.example" }
    describe "#all" do
      it "raises an exception" do
        expect{subject.all}.to raise_exception Errno::ENOTDIR
      end
    end
  end

  context "if directory has 2 files and 1 directory" do
    let(:dir) { "temp_dir" }
    describe "#all" do
      it "returns 3 instances of ExistingEntry" do
        expect(subject.all.map{|e| e.class})
          .to eq [RNR::ExistingEntry,
                  RNR::ExistingEntry,
                  RNR::ExistingEntry
                 ]
      end
    end
  end
end

