class Replacements
  def initialize(file_path)
    @path = file_path
  end

  def renamed(name)
    lines = File.readlines(@path)
    matchdatas = lines.map{|line| line.match(/\/(.*)\/(i?)\s*=>\s*["'](.*)["']/)}
    replacements = Hash[matchdatas.map{|match| [ Regexp.new(match[1], match[2] == "i"), match[3]]}]
    replace = proc { |match|
      regexp = replacements.keys.find{|key| key.match(match)}
      match.gsub(regexp, replacements[regexp])
    }
    pattern = Regexp.union(replacements.keys)
    name.gsub(pattern, &replace)
  end
end
