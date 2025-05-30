{ config, pkgs, lib, ... }:

{
  home.username = "root";
  home.homeDirectory = "/home";
  home.stateVersion = "25.05";

  # packages
  home.packages = with pkgs; [
    # core / deps
    gcc
    binutils
    gnumake
    cmake
    nodejs
    glibc
    ripgrep
    coreutils
    findutils
    gnugrep
    gnused
    gawk
    which
    file
    unzip
    xz
    
    # network
    curl
    wget
    
    # development 
    openssh
    git
    neovim
    bash
    tmux
  ];

  # program configurations
  programs = {
    git = {
      enable = true;
      userName = "mpan322";
      userEmail = "mp322@st-andrews.ac.uk";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };

  # environment variables
  home.sessionVariables = {
    SHELL = "bash";
    EDITOR = "nvim";
    TERM = "xterm-256color";
  };

  # neovim config install script
  home.activation = {
    nvim_config = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [ ! -d ~/.config/nvim/ ]; then
        ${pkgs.git}/bin/git clone -b main https://github.com/mpan322/NvChad.git ~/.config/nvim/
      fi;
    '';
  };

  programs.home-manager.enable = true;
}

