module RNR
  class WithMultiGsub < SimpleDelegator

    def multi_gsub(replacements)
      patterns = replacements.map{|r| r["from"]}
      replace = proc { |match|
        regexp = patterns.find{|p| p.match(match)}
        match.gsub(
          regexp,
          replacements.find{|r| r["from"] == regexp}["to"]
        )
      }
      pattern = Regexp.union(patterns)
      new_name = gsub(pattern, &replace)
      self.class.new(new_name)
    end
  end
end
