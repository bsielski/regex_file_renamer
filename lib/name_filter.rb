class NameFilter
  def initialize(file_path)
    @path = file_path
  end

  def match?(name)
    lines = File.readlines(@path)
    matchdatas = lines.map{|line| line.match(/\/(.*)\/(i?)$/)}
    patterns = matchdatas.map{|match| Regexp.new(match[1], match[2] == "i")}
    patterns.any?{|pattern| pattern.match? name}
  end
end
