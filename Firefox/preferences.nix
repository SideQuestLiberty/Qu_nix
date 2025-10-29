{
  # TODO: Finish configuring with preferences
  # See about:config
  toolkit.legacyUserProfileCustomizations.stylesheets = true;
  browser.theme.toolbar-theme = 0;

  # Zen specific preferences
  zen = {
    downloads.download-animation = false;
    theme.content-element-separation = 0;
    watermark.enabled = false;
    welcome-screen.seen = true;
    #widget.linux.transparency = true;
    view = {
      compact.hide-toolbar = true;
      compact.should-enable-at-startup = true;
      compact.toolbar-flash-popup = true;
      # TODO: make this work
      #compact.toolbar-flash-popup.duration = 500;
      compact.toolbar-hide-after-hover.duration = 800;
      use-single-toolbar = false;
    };
  };
  media.videocontrols.picture-in-picture = {
    enabled = true;
    enable-when-switching-tabs.enabled = true;
  };
}
