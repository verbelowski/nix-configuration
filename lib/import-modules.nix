{ lib, dir }: let
  # File filters.
  # Nix extension and regular file validation.
  isNixFile = name: lib.strings.hasSuffix ".nix" name;
  isModuleFile = name: type: type == "regular" && isNixFile name;

  # Directory loader.
  # Dynamic module discovery and path resolution.
  loadDir = dir:
    if builtins.pathExists dir then
      let
        # Directory processing.
        # Filtered entries and deterministic module ordering.
        entries = lib.filterAttrs isModuleFile (builtins.readDir dir);
        sortedNames = builtins.sort builtins.lessThan (builtins.attrNames entries);
      in
        # File mapping.
        # Directory entries resolved to absolute module paths.
        map (file: dir + "/${file}") sortedNames
    else
      # Missing directory.
      # Module path resolution failure state.
      throw "The module directory \"${dir}\" doesn't exist.";
in
  # Directory evaluation.
  # Module list resolution for input directory.
  loadDir dir
