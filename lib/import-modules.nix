{ dir }:
  # Directory precondition.
  # Target folder existence assertion.
  assert builtins.pathExists dir;
let
  # Folder contents.
  # Sorted directory entries retrieval.
  dirEntries = builtins.readDir dir;
  dirEntryNames = builtins.sort builtins.lessThan (builtins.attrNames dirEntries);

  # Extension criteria.
  # Expression file selector logic.
  isNixFile = name: builtins.match ".*\\.nix$" name != null;
  isRegularNixFile = name: dirEntries.${name} == "regular" && isNixFile name;
in
  # Path resolution.
  # Absolute module location list.
  map (file: dir + "/${file}")
    (builtins.filter isRegularNixFile dirEntryNames)
