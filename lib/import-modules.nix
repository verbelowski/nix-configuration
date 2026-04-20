{ dir }: let
  # Directory scan.
  # File listing from target path.
  dirEntries = builtins.readDir dir;

  # Name list.
  # Attribute names from directory entries.
  dirEntryNames = builtins.attrNames dirEntries;

  # File filter.
  # Nix file pattern matching rule.
  isNixFile = name: builtins.match ".*\\.nix$" name != null;

  # Regular filter.
  # File type and extension validation rule.
  isRegularNixFile = name: dirEntries.${name} == "regular" && isNixFile name;
in
  # Path mapping.
  # Filtered file path construction list.
  map (file: "${dir}/${file}")
    (builtins.filter isRegularNixFile dirEntryNames)
