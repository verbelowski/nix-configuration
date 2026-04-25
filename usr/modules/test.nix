{ pkgs, vars, ... }: {
  home.username = vars.user.name;
  home.homeDirectory = "/home/${vars.user.name}";

  home.packages = with pkgs; [ ];

  systemd.user.startServices = "sd-switch";
}
