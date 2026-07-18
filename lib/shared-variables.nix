{ lib }: {
  # Machine identity.
  # Network hostname identifier.
  hostname = "nixos";

  # Account identity.
  # Primary user details.
  user = {
    name = "vertennn";
    email = "145216301+verbelowski@users.noreply.github.com";
  };

  # State identifier.
  # NixOS and Home Manager compatibility versions.
  stateVersion = "26.05";

  # Text transformation.
  # Uppercase first character string operations.
  capitalize = str: with lib.strings;
    toUpper (substring 0 1 str) + substring 1 (stringLength str - 1) str;
}
