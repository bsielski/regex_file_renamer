require_relative "./existing_entry"

module RNR
  class FilteredEntries
    def initialize(entries, filter)
      @entries = entries
      @filter = filter
    end

    def all
      @entries.all.select do |entry|
        @filter.match? entry.name
      end
    end
  end
end
