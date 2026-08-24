{ dir }:
  # Folder validation.
  # Target path presence requirement.
  assert builtins.pathExists dir;
let
  # Directory contents.
  # Evaluated filesystem element catalog.
  dirEntries = builtins.readDir dir;
  dirEntryNames = builtins.sort builtins.lessThan (builtins.attrNames dirEntries);

  # Extension pattern.
  # Specific language file criteria.
  isNixFile = name: builtins.match ".*\\.nix$" name != null;
  isRegularNixFile = name: dirEntries.${name} == "regular" && isNixFile name;
in
  # Module resolution.
  # Absolute filesystem location index.
  map (file: dir + "/${file}")
    (builtins.filter isRegularNixFile dirEntryNames)
