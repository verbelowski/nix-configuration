{ pkgs, username, stateVersion, ... }: {
  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [ /* empty list */ ];

  /* SECTION TO MOVE + TO MODIFY */

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

  /* SECTION TO MOVE + TO MODIFY */

  systemd.user.startServices = "sd-switch";

  home.stateVersion = stateVersion;
}
