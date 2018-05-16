
files = NamedFiles.new(".")
filtered = FilteredFiles.new(
  files,
  NameFilter.new("filter.txt")
)
replacements = Replacements.new("replacements2.txt")
RenamedFiles.new(
  filtered,
  replacements
).files

=begin

RNR:File <- path
  API:
    read
    name
RNR:RenamedFile <- file, new_name
  API:
    name
RNR:Files <- path
  API:
    all
RNR:FilteredFiles <- files, filters
  API:
    all

config = Config.new("conf.yaml")                 # done
RenamedEntries.new(                              #
  FilteredEntries.new(                           # done
    ExistingEntries.new(config.directory_path)   # done
    Filter.new(config.filters)                   # done
  ).all                                          # done
  config.replacements                            # done
).all                                            #

<a href=\2 target="_blank">\1\2\3<\/a>
=end

