{ lib }: {
  # String capitalization.
  # Uppercase first character of input string.
  capitalize = str: with lib.strings; toUpper (substring 0 1 str) + substring 1 (stringLength str - 1) str;
}
