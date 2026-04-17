{ dir }: let
  # Directory entries.
  # Raw filesystem listing for target path.
  dirEntries = builtins.readDir dir;
  dirEntryNames = builtins.attrNames dirEntries;

  # File filters.
  # Nix extension and regular file validation.
  isNixFile = name: builtins.match ".*\\.nix$" name != null;
  isRegularNixFile = name: dirEntries.${name} == "regular" && isNixFile name;
in
  # Module paths.
  # Filtered directory entries mapped to absolute file paths.
  map (file: "${dir}/${file}")
    (builtins.filter isRegularNixFile dirEntryNames)
