{ lib, vars, ... }: let
  capitalize = str: with lib.strings; toUpper (substring 0 1 str) + substring 1 (stringLength str - 1) str;
in {
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = capitalize vars.user.name;
        email = vars.user.email;

        useConfigOnly = true;
      };

      init.defaultBranch = "main";

      core = {
        editor = "nvim";
        autocrlf = "input";
      };

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

      /* do kluczy */
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };

      commit.gpgsign = true;

      url."git@github.com:".insteadOf = "https://github.com/";
    };
      /* do kluczy */
    signing.key = "~/.ssh/id_ed25519.pub";
    signing.signByDefault = true;
  };
}
