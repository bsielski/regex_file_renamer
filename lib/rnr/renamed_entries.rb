require_relative "with_multi_gsub"

module RNR
  class RenamedEntries
    def initialize(entries, replacements)
      @entries = entries
      @replacements = replacements
    end

    def all
      @entries.all.map do |entry|
        old_name = RNR::WithMultiGsub.new(entry.name)
        next entry.rename(old_name.multi_gsub(@replacements))
      end
    end
  end
end
