
{ config, pkgs, ... }:

{
  # This one block handles the following:
  # - Installs Wayfire
  # - Automatically adds it to the SDDM session list
  # - Wraps it with the plugins you list below
  programs.wayfire = {
    enable = true;

    # This declaratively builds the "wrapped" package
    # with specified plugins
    plugins = with pkgs.wayfirePlugins; [
      wcm       # The Wayfire Config Manager GUI
      wf-shell  # The panel, background, etc.
      # Add any more plugins here
      # wayfire-plugins-extra
    ];
  };
}