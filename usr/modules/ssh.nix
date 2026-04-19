{ ... }: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "*" = {
        identitiesOnly = true;
        addKeysToAgent = true;
        serverAliveInterval = 60;
        serverAliveCountMax = 3;
        strictHostKeyChecking = "accept-new";
      };

      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
