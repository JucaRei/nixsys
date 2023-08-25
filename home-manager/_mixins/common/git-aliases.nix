_: {
  program.git = {
    aliases = {
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      branch-default = ''
        !git symbolic-ref --short refs/remotes/origin/HEAD | sed "s|^origin/||"
      '';
      checkout-default = ''!git checkout "$(git branch-default)"'';
      rebase-default = ''!git rebase "$(git branch-default)"'';
      merge-default = ''!git merge "$(git branch-default)"'';
      branch-cleanup = ''
        !git branch --merged | egrep -v "(^\*|master|main|dev|development)" | xargs git branch -d #
      '';
      # Restores the commit message from a failed commit for some reason
      fix-commit = ''
        !git commit -F "$(git rev-parse --git-dir)/COMMIT_EDITMSG" --edit
      '';
      pushf = "push --force-with-lease";
      logs = "log --show-signature";
      # Show the diff between the latest commit and the current state.
      d = "!git diff-index --quiet HEAD -- || clear; git diff --patch-with-stat";
      # `git di $number` shows the diff between the state `$number` revisions ago and the current state.
      di = "!d() { git diff --patch-with-stat HEAD~$1; }; git diff-index --quiet HEAD -- || clear; d";
      # Pull in remote changes for the current repository and all its submodules.
      p = "pull --recurse-submodules";
      # Clone a repository including all submodules.
      c = "clone --recursive";
      # Fetch remote.
      f = "fetch --prune";

      # Show verbose output about tags, branches or remotes.
      tags = "tag -l";
      branches = "branch --all";
      remotes = "remote --verbose";

      # List aliases.
      aliases = "config --get-regexp alias";

      # Commit.
      co = "commit";
      com = "commit -m";
      coa = "!git add -A && git commit -av";

      # Amend commit.
      amend = "commit --amend --reuse-message=HEAD";
      ca = "commit --amend";
      can = "commit --amend --no-edit";
      car = "commit --amend --reset-author";
      carn = "commit --amend --reset-author --no-edit";

      # Credit an author on the latest commit.
      credit = ''!f() { git commit --amend --author "$1 <$2>" -C HEAD; }; f'';

      reb = "rebase -i origin/HEAD --autosquash";
      # Interactive rebase with the given number of latest commits.
      rebn = "!r() { git rebase -i HEAD~$1 --autosquash; }; r";

      # Remove the old tag with this name and tag the latest commit with it.
      retag = "!r() { git tag -d $1 && git push origin :refs/tags/$1 && git tag $1; }; r";

      # List contributors with number of commits.
      contributors = "shortlog --summary --numbered";

      # Show the user email for the current repository.
      whoami = "config user.email";
    };
  };
}
