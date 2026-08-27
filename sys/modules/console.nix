{ pkgs, ... }: {
  # TTY console.
  # Virtual screen layout options.
  console = {
    font = "Lat2-Terminus16";
    keyMap = "pl";
    earlySetup = true;
  };

  # System services.
  # Background daemon framework controls.
  services = {
    # Terminal login.
    # Console prompt display arguments.
    getty.extraArgs = [ "--nonewline" "--noissue" "--noreset" "--noclear" ];

    # Login manager.
    # Console login display manager.
    greetd = {
      # Activation state.
      # Console greeter daemon switch.
      enable = true;

      # Interface mode.
      # Virtual terminal greeter preference.
      useTextGreeter = true; # TODO: Switch to `programs.regreet.enable` and remove `useTextGreeter` for GUI once the configuration is complete.

      # Session launcher.
      # Default user environment command.
      settings.default_session.command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd start-hyprland";
    };
  };
}
