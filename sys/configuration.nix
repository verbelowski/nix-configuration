{ pkgs, vars, ... }: {
  # Module imports.
  # System configuration modules.
  imports = import ../lib/import-modules.nix {
    dir = ../sys/modules;
  };

  # Package selection.
  # Additional packages in system environment.
  environment.systemPackages = with pkgs; [ ];

  # State version.
  # NixOS compatibility version.
  system.stateVersion = vars.stateVersion;
}
