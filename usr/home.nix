{ pkgs, vars, ... }: {
  # External modules.
  # User directory component declarations.
  imports = import ../lib/import-modules.nix {
    dir = ../usr/modules;
  };

  # Platform domain.
  # User profile resource specifications.
  home = {
    # Account identity.
    # User workspace record details.
    username = vars.user.name;
    homeDirectory = "/home/${vars.user.name}";

    # User software.
    # Individual profile binary packages.
    packages = with pkgs; [ ];

    # Runtime parameters.
    # User environment variable definitions.
    sessionVariables.NIXOS_OZONE_WL = "1"; # TODO: Expand to an attribute set as environment variables grow.

    # State compatibility.
    # Backwards migration release baseline.
    stateVersion = vars.stateVersion;
  };
}
