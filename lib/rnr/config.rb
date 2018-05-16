require "yaml"

module RNR
  class Config
    def initialize(yml_file_path)
      @yml_file_path = yml_file_path
    end

    def directory
      yaml["directory"]
    end

    def names
      yaml["names"].map do |pattern|
        regex_from_string(pattern)
      end
    end

    def replacements
      yaml["replacements"].map do |pattern|
        {
          "from" => regex_from_string(pattern["from"]),
          "to" => pattern["to"]
        }
      end
    end

    private

    def yaml
      YAML.load_file(@yml_file_path)
    end
    
    def regex_from_string(str)
      match = str.match(/\/(.*)\/(i?)$/)
      Regexp.new(match[1], match[2] == "i")
    end
  end
end
