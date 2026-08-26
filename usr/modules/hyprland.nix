{ config, ... }: {
  # Wayland compositor.
  # Dynamic tiling window manager.
  wayland.windowManager.hyprland = {
    # Service activation.
    # Background daemon execution switch.
    enable = true;

    # Component references.
    # External binary override sources.
    package = null;
    portalPackage = null;
  };

  # Session configuration.
  # Environment variables file.
  xdg.configFile."uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
}
