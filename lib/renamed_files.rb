class RenamedFiles < SimpleDelegator
  def initialize(source, replacements)
    @source = source
    super(source)
    @replacements = replacements
  end

  def names
    @source.files.map{ |file| file.rename(@replacements.renamed(file.name)) }
  end

  def files
    super.map{|file| file.name}.map{|name| @replacements.renamed(name)}
  end
  
  def save
  end
end
