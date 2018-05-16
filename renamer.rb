require_relative "lib/rnr/config"
require_relative "lib/rnr/existing_entries"
require_relative "lib/rnr/existing_entry"
require_relative "lib/rnr/filter"
require_relative "lib/rnr/filtered_entries"
require_relative "lib/rnr/renamed_entries"
require_relative "lib/rnr/with_multi_gsub"



config = RNR::Config.new("renamer_configuration.yaml")

RNR::RenamedEntries.new(
  RNR::FilteredEntries.new(
    RNR::ExistingEntries.new(config.directory),
    RNR::Filter.new(config.names)
  ),
  config.replacements
).all
