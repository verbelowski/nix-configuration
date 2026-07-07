{ lib }: {
  # Host identity.
  # Machine network hostname.
  hostname = "nixos";

  # User identity.
  # Primary user account details.
  user = {
    name = "vertennn";
    email = "145216301+verbelowski@users.noreply.github.com";
  };

  # State version.
  # NixOS and Home Manager compatibility version.
  stateVersion = "26.05";

  # String capitalization.
  # Uppercase first character of `user.name`.
  capitalize = str: with lib.strings;
    toUpper (substring 0 1 str) + substring 1 (stringLength str - 1) str;
}
