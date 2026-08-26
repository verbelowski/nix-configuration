{ config, ... }: {
  # Wayland compositor.
  # Dynamic tiling window manager.
  wayland.windowManager.hyprland = {
    # Activation state.
    # Background daemon execution switch.
    enable = true;

    # Component references.
    # External binary override sources.
    package = null;
    portalPackage = null;

    # Integration state.
    # System manager control option.
    systemd.enable = false; # NOTE: Home Manager's systemd integration is disabled to avoid conflicts with `programs.hyprland.withUWSM`.
  };

  # Session configuration.
  # Environment variables file.
  xdg.configFile."uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
}
