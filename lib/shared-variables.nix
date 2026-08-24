{ lib }: {
  # Machine identity.
  # Network node label string.
  hostname = "nixos";

  # Account profile.
  # User metadata record.
  user = {
    name = "vertennn";
    email = "145216301+verbelowski@users.noreply.github.com";
  };

  # State compatibility.
  # Backwards migration release baseline.
  stateVersion = "26.05";

  # Text transformation.
  # Initial letter case conversion.
  capitalize = str: with lib.strings;
    toUpper (substring 0 1 str) + substring 1 (stringLength str - 1) str;
}
