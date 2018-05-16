module RNR
  class ExistingEntry
    def initialize(path)
      @path = path
    end

    def name
      raise Errno::ENOENT unless File.exist?(@path)
      File.basename(@path)
    end

    def rename(new_name)
      new_path = File.join(File.dirname(@path), new_name)
      File.rename(@path, new_path)
      self.class.new(new_path)
    end
  end
end
