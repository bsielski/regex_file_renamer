module RNR
  class Filter
    def initialize(regexps)
      @regexps = regexps
    end

    def match?(name)
      @regexps.any? do |regexp|
        regexp.match? name
      end
    end
  end
end
