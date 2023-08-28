{pkgs, ...}: {
  imports = [
    ../../../resources/git/aliases.nix
  ];
  programs = {
    git = {
      enable = true;

      package = pkgs.gitFull.override {
        # Use SSH from macOS instead with support for Keyring
        # https://github.com/NixOS/nixpkgs/issues/62353
        withSsh = !pkgs.stdenv.isDarwin;
      };

      delta = {
        enable = true;
        options = {
          features = "side-by-side line-numbers decorations";
          navigate = true;
          syntax-theme = "Dracula";
          plus-style = ''syntax "#003800"'';
          minus-style = ''syntax "#3f0001"'';
          decorations = {
            commit-decoration-style = "bold yellow box ul";
            file-style = "bold yellow ul";
            file-decoration-style = "none";
            hunk-header-decoration-style = "cyan box ul";
          };
          delta = {navigate = true;};
          line-numbers = {
            line-numbers-left-style = "cyan";
            line-numbers-right-style = "cyan";
            line-numbers-minus-style = 124;
            line-numbers-plus-style = 28;
          };
        };
      };

      extraConfig = {
        push = {
          default = "matching";
          autoSetupRemote = true;
        };
        pull = {
          rebase = true;
        };
        rebase = {
          autoStash = true;
        };
        branch = {
          sort = "-committerdate";
        };
        color = {ui = true;};
        init = {
          defaultBranch = "main";
        };
        core = {
          editor = "nvim";
          whitespace = "trailing-space,space-before-tab,indent-with-non-tab";
        };
        checkout = {
          defaultRemote = "origin";
        };
        diff = {
          colorMoved = "default";
        };
        merge = {
          conflictstyle = "diff3";
          tool = "nvim -d";
        };
        github = {
          user = "Reinaldo";
        };
        commit = {
          verbose = true;
        };
        url = {
          "https://github.com/".insteadOf = "gh:";
          "https://gitlab.com/".insteadOf = "gl:";
          "https://gist.github.com/".insteadOf = "gist:";
          "git@gist.github.com".pushInsteadOf = "gist:";
          "git@gitlab.com:".pushInsteadOf = "gl:";
          "git@github.com:".pushInsteadOf = "gh:";
        };
      };

      ignores = [
        "*.log"
        "*.out"
        ".DS_Store"
        "bin/"
        "dist/"
        "result"
        ".cache/"
        ".DS_Store"
        ".direnv/"
        "*.swp"
        "*~"
        ".vscode/"
        "npm-debug.log"
        "dumb.rdb"
        "Thumbs.db"
      ];
      #includes = [
      #  {
      #    path = "~/.config/git/local";
      #  }
      #];
    };
  };
}
