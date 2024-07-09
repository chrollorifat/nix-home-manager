# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    #./core-packages.nix
    #./desktop-packages.nix
    # ./env.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # TODO: Set your username
  home = {
    username = "rif";
    homeDirectory = "/home/rif";
  };


  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [ 
    ponysay
    i3
    i3status
    i3lock
    i3-gaps
    awesome
    light
    hilbish

 ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userEmail = "officialmhrifat@outlook.com";
    userName = "ChrolloRifat";
    includes = [
      {path = "~/.gitconfig";}
    ];
    extraConfig = {
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
          }; 
      };
      init = {
        defaultBranch = "main";
      };
    };
  };

  # Enable pqiv
  programs.pqiv = {
    enable = true;
  };

 # Enable AwesomeWM
 xsession.windowManager.awesome = {
   enable = true;
   luaModules = [
    
   ];

 };
  
  # …

  xsession.enable = true;
  # xsession.windowManager.command = "…";


  # …
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
