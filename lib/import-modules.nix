{ dir }:
  # Path assertion.
  # Target directory existence verification.
  assert builtins.pathExists dir;
let
  # Directory contents.
  # Sorted filesystem entry collection.
  dirEntries = builtins.readDir dir;
  dirEntryNames = builtins.sort builtins.lessThan (builtins.attrNames dirEntries);

  # Expression filters.
  # Evaluation predicate match logic.
  isNixFile = name: builtins.match ".*\\.nix$" name != null;
  isRegularNixFile = name: dirEntries.${name} == "regular" && isNixFile name;
in
  # Path resolution.
  # Absolute source location mapping.
  map (file: dir + "/${file}")
    (builtins.filter isRegularNixFile dirEntryNames)
