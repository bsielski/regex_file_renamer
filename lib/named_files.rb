class NamedFiles
  def initialize(path)
    @path = path
  end

  def files
    Dir.children(@path)
      .select{|child| File.file?(child)}
      .map {|file_name| NamedFile.new(to_path(file_name))}
  end

  private
  
  def to_path(file_name)
    [@path, file_name].join("/")
  end 
end
