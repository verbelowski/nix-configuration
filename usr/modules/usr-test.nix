{ pkgs, vars, ... }: {
  home.username = vars.username;
  home.homeDirectory = "/home/${vars.username}";

  home.packages = with pkgs; [ /* empty list */ ];

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Vertennn";
        email = "145216301+verbelowski@users.noreply.github.com";
      };

      init.defaultBranch = "main";
    };
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = vars.stateVersion;
}
