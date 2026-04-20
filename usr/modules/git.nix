{ lib, vars, ... }: let
  capitalize = str: with lib.strings; toUpper (substring 0 1 str) + substring 1 (stringLength str - 1) str;
in {
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = capitalize vars.user.name;
        email = vars.user.email;

        signingKey = "~/.ssh/id_ed25519"; # idk czy pub czy prywatny

        useConfigOnly = true;
      };

      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };

      commit.gpgSign = true;

      init.defaultBranch = "main";

      core = {
        editor = "nvim";
        autocrlf = "input";
      };

      url."git@github.com:".insteadOf = "https://github.com/";

      fetch.prune = true;

      pull.rebase = true;

      push = {
        default = "simple";
        autoSetupRemote = true;
      };

      rebase = {
        autoStash = true;
        autoSquash = true;
      };

      merge.conflictStyle = "zdiff3";

      safe.directory = "*";
    };
  };
}
