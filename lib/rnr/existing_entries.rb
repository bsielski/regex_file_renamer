require_relative "./existing_entry"

module RNR
  class ExistingEntries
    def initialize(path)
      @path = path
    end

    def all
      Dir.children(@path).map do |file_name|
        ExistingEntry.new(File.join(@path, file_name))
      end
    end
  end
end
