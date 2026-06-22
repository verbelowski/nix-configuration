{ dir }:
  # Directory validation.
  # Existence requirement for input directory.
  assert builtins.pathExists dir;
let
  # Directory listing.
  # Sorted names of all directory entries.
  dirEntries = builtins.readDir dir;
  dirEntryNames = builtins.sort builtins.lessThan (builtins.attrNames dirEntries);

  # Entry filtering.
  # Predicates for regular Nix file recognition.
  isNixFile = name: builtins.match ".*\\.nix$" name != null;
  isRegularNixFile = name: dirEntries.${name} == "regular" && isNixFile name;
in
  # Path mapping.
  # Absolute paths of matched Nix files.
  map (file: dir + "/${file}")
    (builtins.filter isRegularNixFile dirEntryNames)
