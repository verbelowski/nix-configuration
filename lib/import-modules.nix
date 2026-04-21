{ dir }:
  # Path validation.
  # Directory existence requirement check.
  assert builtins.pathExists dir;
let
  # Directory scan.
  # Directory entry listing result.
  dirEntries = builtins.readDir dir;

  # Name sorting.
  # Alphabetical directory entry ordering.
  dirEntryNames = builtins.sort builtins.lessThan (builtins.attrNames dirEntries);

  # File filtering.
  # Regular file entries with Nix extension matching.
  isNixFile = name: builtins.match ".*\\.nix$" name != null;
  isRegularNixFile = name: dirEntries.${name} == "regular" && isNixFile name;
in
  # Path mapping.
  # Filtered file path list construction.
  map (file: dir + "/${file}")
    (builtins.filter isRegularNixFile dirEntryNames)
