{ pkgs, vars, ... }: {
  # Module imports.
  # System configuration module list.
  imports = import ../lib/import-modules.nix {
    dir = ../sys/modules;
  };

  # Package selection.
  # Additional system environment packages.
  environment.systemPackages = with pkgs; [ ];

  # State version.
  # NixOS compatibility version identifier.
  system.stateVersion = vars.stateVersion;
}
