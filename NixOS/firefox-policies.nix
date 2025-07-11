{
  # See about:policies
  ExtensionSettings =
  let NewExt = ID: UUID: {
    name = UUID;
    value = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/${ID}/latest.xpi";
      installation_mode = "force_installed";
    };
  };
  in builtins.listToAttrs [
    (NewExt "ublock-origin" "uBlock0@raymondhill.net")
    (NewExt "decentraleyes" "jid1-BoFifL9Vbdl2zQ@jetpack")
    (NewExt "privacy-badger17" "jid1-MnnxcxisBPnSXQ@jetpack")
    (NewExt "istilldontcareaboutcookies" "idcac-pub@guus.ninja")
    (NewExt "clearurls" "{74145f27-f039-47ce-a470-a662b129930a}")
    (NewExt "shorts-deflector" "shortsdeflector@addons.com")
    (NewExt "hide-youtube-shorts" "{88ebde3a-4581-4c6b-8019-2a05a9e3e938}")
    (NewExt "proton-pass" "78272b6fa58f4a1abaac99321d503a20@proton.me")
    (NewExt "darkreader" "addon@darkreader.org")
    (NewExt "styl-us" "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}")
    { name = "*"; value = { installation_mode = "blocked"; }; }
  ];
  SearchEngines = {
    Default = "DuckDuckGo";
    DefaultPrivate = "DuckDuckGo";
    Remove = [
      "Google"
      "Bing"
      "Qwant"
    ];
    Add = [
      {
        Name = "Catppuccin Repository";
        Alias = "@cp";
        Description = "Search in Catppuccin Repositories";
        Method = "GET";
        IconURL = "https://catppuccin.com/favicon.png";
        URLTemplate = "https://github.com/orgs/catppuccin/repositories?q={searchTerms}";
      }
      {
        Name = "DeepL Translator";
        Alias = "@tr";
        Description = "Translate a string to french";
        Method = "GET";
        IconURL = "https://deepl.com/favicon.ico";
        URLTemplate = "https://www.deepl.com/en/translator#auto/fr/{searchTerms}";
      }
      {
        Name = "NixOS Packages";
        Alias = "@np";
        Description = "Search in NixOS Packages";
        Method = "GET";
        IconURL = "https://search.nixos.org/favicon.png";
        URLTemplate = "https://search.nixos.org/packages?from=0&size=200&sort=relevance&type=packages&query={searchTerms}";
      }
      {
        Name = "NixOS Options";
        Alias = "@no";
        Description = "Search in NixOS Options";
        Method = "GET";
        IconURL = "https://search.nixos.org/favicon.png";
        URLTemplate = "https://search.nixos.org/options?from=0&size=200&sort=relevance&type=packages&query={searchTerms}";
      }
    ];
  };
  Bookmarks = [
#    {
#      Title = "";
#      URL = "";
#      Favicon = "";
#      Placement = "";
#      Folder = "";
#    }
  ];
  EnableTrackingProtection = {
    Value = true;
    Locked = true;
    Cryptomining = true;
    Fingerprinting = true;
    EmailTracking = true;
  };
  FirefoxHome = {
    Search = true;
    TopSites = false;
    SponsoredTopSites = false;
    Highlights = false;
    Pocket = false;
    Stories = false;
    SponsoredPocket = false;
    SponsoredStories = false;
    Snippets = false;
    Locked = true;
  };
  FirefoxSuggest = {
    WebSuggestions = false;
    SponsoredSuggestions = false;
    ImproveSuggest = false;
    Locked = true;
  };
  DisableAppUpdate = true;
  AutofillAddressEnabled = false;
  AutofillCreditCardEnabled = false;
  DefaultDownloadDirectory = "~/";
  DisableAccounts = true;
  DisableFeedbackCommands = true;
  DisableFirefoxAccounts = true;
  DisableFirefoxScreenshots = true;
  DisableFirefoxStudies = true;
  DisableFormHistory = true;
  DisableSetDesktopBackground = true;
  DisableTelemetry = true;
  DisplayBookmarksToolbar = "newtab";
  DisplayMenuBar = "default-off";
  DontCheckDefaultBrowser = true;
  NoDefaultBookmarks = true;
  OfferToSaveLogins = false;
  OverrideFirstRunPage = "";
  OverridePostUpdatePage = "";
  PasswordManagerEnabled = false;
  PrimaryPassword = false;
  PromptForDownloadLocation = true;
  SearchBar = "unified";
  SearchSuggestEnabled = false;
  ShowHomeButton = false;
  SkipTermsOfUse = true;
  TranslateEnabled = false;
}
