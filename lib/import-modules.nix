{ dir }:
  # Directory validation.
  # Input directory existence requirement.
  assert builtins.pathExists dir;
let
  # Directory listing.
  # Sorted directory entry names.
  dirEntries = builtins.readDir dir;
  dirEntryNames = builtins.sort builtins.lessThan (builtins.attrNames dirEntries);

  # Entry filtering.
  # Regular Nix file recognition predicates.
  isNixFile = name: builtins.match ".*\\.nix$" name != null;
  isRegularNixFile = name: dirEntries.${name} == "regular" && isNixFile name;
in
  # Path mapping.
  # Absolute paths of matched Nix files.
  map (file: dir + "/${file}")
    (builtins.filter isRegularNixFile dirEntryNames)
