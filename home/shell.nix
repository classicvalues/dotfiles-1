{ config, pkgs, ... }:

let
  shellAliases = {
    # Apps... but better
    git = "hub";
    vim = "nvim";
    ls = "exa";
    cat = "bat";
    find = "fd";

    # ls
    l = "ls -l";
    ll = "ls -la";

    # misc
    tree = "exa --tree";
    reload = "exec fish";
    oo = "open .";
  };

  shellAbbrs = {
    gs = "git status -sb";
    ga = "git add";
    gc = "git commit";
    gcm = "git commit -m";
    gca = "git commit --amend";
    gcl = "git clone";
    gco = "git checkout";
    gp = "git push";
    gpl = "git pull";
    gl = "git l";
    gd = "git diff";
    gds = "git diff --staged";
    gr = "git rebase -i HEAD~15";
    gf = "git fetch";
    gfc = "git findcommit";
    gfm = "git findmessage";
  };
in {
  home.packages = with pkgs; [
    fzf
    jump
  ];

  programs.starship.enable = true;

  programs.fish = {
    inherit shellAliases shellAbbrs;
    enable = true;

    shellInit = ''
      # Initialize homebrew
      eval (/opt/homebrew/bin/brew shellenv)

      # Set NVM prefix
      set -gx nvm_prefix /opt/homebrew/opt/nvm
      
      # Disable fish greeting
      set -g fish_greeting ""

      # Set fish syntax highlighting
      set -g fish_color_autosuggestion '555'  'brblack'
      set -g fish_color_cancel -r
      set -g fish_color_command --bold
      set -g fish_color_comment red
      set -g fish_color_cwd green
      set -g fish_color_cwd_root red
      set -g fish_color_end brmagenta
      set -g fish_color_error brred
      set -g fish_color_escape 'bryellow'  '--bold'
      set -g fish_color_history_current --bold
      set -g fish_color_host normal
      set -g fish_color_match --background=brblue
      set -g fish_color_normal normal
      set -g fish_color_operator bryellow
      set -g fish_color_param cyan
      set -g fish_color_quote yellow
      set -g fish_color_redirection brblue
      set -g fish_color_search_match 'bryellow'  '--background=brblack'
      set -g fish_color_selection 'white'  '--bold'  '--background=brblack'
      set -g fish_color_user brgreen
      set -g fish_color_valid_path --underline
    '';

    interactiveShellInit = ''
      # Initialize Jump
      source (jump shell fish | psub)
    '';

    plugins = [
      {
        name = "fish-colored-man";
        src = pkgs.fetchFromGitHub {
          owner = "decors";
          repo = "fish-colored-man";
          rev = "master";
          sha256 = "16ar220pz8lmv58c8fj81mi7slk0qb20dh5zdwcyyw12dgzahsvr";
        };
      }
      {
        name = "nvm-fish";
        src = pkgs.fetchFromGitHub {
          owner = "FabioAntunes";
          repo = "fish-nvm";
          rev = "master";
          sha256 = "0q2bh9hpq1nkgjs9adsa8d8b5gh8c3k496xvnjsjfn7qdfgmbcil";
        };
      }
      {
        name = "bass";
        src = pkgs.fetchFromGitHub {
          owner = "edc";
          repo = "bass";
          rev = "master";
          sha256 = "0mb01y1d0g8ilsr5m8a71j6xmqlyhf8w4xjf00wkk8k41cz3ypky";
        };
      }
    ];
  };

  programs.zsh = {
    inherit shellAliases;
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    history.extended = true;
  };
}
