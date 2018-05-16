require "rnr/config"
require 'fileutils'
require "yaml"

RSpec.describe "RNR::Config" do
  subject { RNR::Config.new(yml_file_path) }
  let(:yml_file_path) {
    Dir.mkdir("temp_dir")
    File.open("temp_dir/renamer.yaml", "w") do |file|
      file.write(YAML.dump(config))
    end
    "temp_dir/renamer.yaml"
  }
  
  after(:example) do
    FileUtils.rm_r("temp_dir")
  end
  
  context "with some config" do
    let(:config) {
      { "directory" => ".",
        "names" => ["/\\.wmv$/i", "/\\.mp4$/i"],
        "replacements" => [ { "from" => "/a/", "to" => "a" },
                            { "from" => "/(b)/i", "to" => "\\1\\1" } ]
      }
    }
    it "has directory path" do
      expect(subject.directory).to eq "."
    end
    
    it "has file patterns" do
      expect(subject.names)
        .to eq [ /\.wmv$/i, /\.mp4$/i ]
    end

    it "has replacements" do
      expect(subject.replacements)
        .to eq [ { "from" => /a/, "to" => "a" },
                 { "from" => /(b)/i, "to" => "\\1\\1" } ]
    end    
  end
  
  context "with some other config" do
    let(:config) {
      { "directory" => "some_dir",
        "names" => [ "/(...+).*\\1/i", "/\\.AVI$/" ],
        "replacements" => [ { "from" => "/cat/", "to" => "dog" },
                            { "from" => "/(one)(two)/i", "to" => "\\2\\1" } ]
      }
    }
    it "has directory path" do
      expect(subject.directory).to eq "some_dir"
    end
    
    it "has file patterns" do
      expect(subject.names)
        .to eq [ /(...+).*\1/i, /\.AVI$/ ]
    end

    it "has replacements" do
      expect(subject.replacements)
        .to eq [ { "from" => /cat/, "to" => "dog" },
                 { "from" => /(one)(two)/i, "to" => "\\2\\1" } ]
    end    
  end
end
