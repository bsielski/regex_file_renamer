class NamedFile
  def initialize(path)
    @path = path
  end

  def name
    File.basename(@path)
  end
  
  def rename(name)
    File.rename(@path, name)
    self.class.new(name)
  end

  # def read
  #   File.open(@path) do |f|
  #     f.readlines
  #   end
  # end
end
