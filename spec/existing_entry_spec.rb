require "rnr/existing_entry"
require 'fileutils'

RSpec.describe "RNR::ExistingEntry" do
  subject { RNR::ExistingEntry.new(path) }
  let(:path) { File.join(dir, file) }
  let(:dir) { "temp_dir" }
  let(:file) { "file.example" }
  
  before(:example) do
    Dir.mkdir("temp_dir")
    Dir.mkdir("temp_dir/sub_dir")
    File.open("temp_dir/sub_dir/file_in_sub.example", "w"){}
    File.open("temp_dir/file.example", "w"){}
  end

  after(:example) do
    FileUtils.rm_r("temp_dir")
  end
  
  context "if file exists" do
    describe "#name" do
      it "gives the name" do
        expect(subject.name).to eq "file.example"
      end
    end

    describe "#rename" do
      it "changes the file name on a disk" do
        subject.rename("file_with_new_name.example")
        expect(File.exist?("temp_dir/file_with_new_name.example")).to be true
      end

      it "changes the name of the object" do
        expect(subject.rename("file_with_new_name.example").name).to eq "file_with_new_name.example"
      end

      it "returns an ExistingEntry instance" do
        expect(subject.rename("file_with_new_name.example")).to be_kind_of RNR::ExistingEntry
      end

      it "returns a new object" do
        expect(subject.rename("file_with_new_name.example")).to_not be subject
      end
    end
  end

  context "if file doesn't exist" do
    let(:file) { "incorrect_file.example" }
    describe "#name" do
      it "raises an exception" do
        expect{subject.name}.to raise_exception Errno::ENOENT
      end
    end

    describe "#rename" do
      it "raises an exception" do
        expect{subject.rename("file_with_new_name.example")}.to raise_exception Errno::ENOENT
      end
    end
  end

  context "if dir path is incorrect" do
    let(:dir) { "incorrect_temp_dir" }
    describe "#name" do
      it "raises an exception" do
        expect{subject.name}.to raise_exception Errno::ENOENT
      end
    end

    describe "#rename" do
      it "raises an exception" do
        expect{subject.rename("file_with_new_name.example")}.to raise_exception Errno::ENOENT
      end
    end
  end

  context "if file is a directory" do
    let(:path) { "temp_dir/sub_dir" }
    describe "#name" do
      it "gives the name of the directory" do
        expect(subject.name).to eq "sub_dir"
      end
    end

    describe "#rename" do
      it "changes the directory name on a disk" do
        subject.rename("renamed_sub_dir")
        expect(File.exist?("temp_dir/renamed_sub_dir")).to be true
      end

      it "changes the name of the object" do
        expect(subject.rename("renamed_sub_dir").name).to eq "renamed_sub_dir"
      end

      it "returns an ExistingEntry instance" do
        expect(subject.rename("renamed_sub_dir")).to be_kind_of RNR::ExistingEntry
      end

      it "returns a new object" do
        expect(subject.rename("renamed_sub_dir")).to_not be subject
      end
    end
  end

end

