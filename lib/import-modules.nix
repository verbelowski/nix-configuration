{ dir }: let
  # Directory listing.
  # Raw filesystem scan output.
  dirEntries = builtins.readDir dir;
  dirEntryNames = builtins.attrNames dirEntries;

  # File matcher.
  # Nix extension validation rule.
  isNixFile = name: builtins.match ".*\\.nix$" name != null;

  # File filter.
  # Regular Nix file constraint.
  isRegularNixFile = name: dirEntries.${name} == "regular" && isNixFile name;
in
  # Module paths.
  # Filtered Nix module path list.
  map (file: "${dir}/${file}")
    (builtins.filter isRegularNixFile dirEntryNames)
