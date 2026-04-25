{ dir }:
  # Directory validation.
  # Ensure directory existence.
  assert builtins.pathExists dir;
let
  # Directory listing.
  # Read directory entries.
  dirEntries = builtins.readDir dir;
  dirEntryNames = builtins.sort builtins.lessThan (builtins.attrNames dirEntries);

  # Entry filtering.
  # Select regular files only.
  isNixFile = name: builtins.match ".*\\.nix$" name != null;
  isRegularNixFile = name: dirEntries.${name} == "regular" && isNixFile name;
in
  # Path mapping.
  # Map filtered files to full paths.
  map (file: dir + "/${file}")
    (builtins.filter isRegularNixFile dirEntryNames)
