{
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;

    extraConfig = ''
      Host github.com
        HostName github.com
        User git
        IdentityFile ~/.ssh/id_ed25519_auth
        IdentitiesOnly yes
    '';
  };

  programs.git = {
    enable = true;

    userName = "Vertennn";
    userEmail = "145216301+verbelowski@users.noreply.github.com";

    signing = {
      signByDefault = true;
      key = "~/.ssh/id_ed25519_signing.pub";
      format = "ssh";
    };

    extraConfig = {
      gpg.format = "ssh";
      commit.gpgsign = true;

      user.signingkey = "~/.ssh/id_ed25519_signing.pub";
    };
  };
}
