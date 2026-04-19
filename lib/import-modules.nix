{ dir }: let
  # Directory entries.
  # Filesystem directory listing.
  dirEntries = builtins.readDir dir;
  dirEntryNames = builtins.attrNames dirEntries;

  # Nix file filter.
  # File extension match.
  isNixFile = name: builtins.match ".*\\.nix$" name != null;

  # Regular file filter.
  # File type validation.
  isRegularNixFile = name: dirEntries.${name} == "regular" && isNixFile name;
in
  # Module paths.
  # Filtered file paths list.
  map (file: "${dir}/${file}")
    (builtins.filter isRegularNixFile dirEntryNames)
