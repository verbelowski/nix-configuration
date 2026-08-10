{ lib }: {
  # Host identifier.
  # Unique network machine name.
  hostname = "nixos";

  # Operator identity.
  # Account profile metadata defaults.
  user = {
    name = "vertennn";
    email = "145216301+verbelowski@users.noreply.github.com";
  };

  # State compatibility.
  # Backwards migration release baseline.
  stateVersion = "26.05";

  # String helper.
  # Capital initial letter function.
  capitalize = str: with lib.strings;
    toUpper (substring 0 1 str) + substring 1 (stringLength str - 1) str;
}
