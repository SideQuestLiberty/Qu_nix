# See about:policies
{
  Preferences = import ./preferences.nix;

  # Configure extensions
  ExtensionUpdate = true;
  ExtensionSettings =
    # You can find the extension ID in the URL of the addon page ;
    # - if the installation_mode is set to "blocked", the UUID will be in a popup
    # - else, go to about:support and you should find the UUID under "extensions"
    let
      NewExt = ID: UUID: {
        "${UUID}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/${ID}/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    in
    # The // operator merges all of these sets into a single set
    NewExt "ublock-origin" "uBlock0@raymondhill.net"
    // NewExt "decentraleyes" "jid1-BoFifL9Vbdl2zQ@jetpack"
    // NewExt "privacy-badger17" "jid1-MnnxcxisBPnSXQ@jetpack"
    // NewExt "istilldontcareaboutcookies" "idcac-pub@guus.ninja"
    // NewExt "clearurls" "{74145f27-f039-47ce-a470-a662b129930a}"
    // NewExt "shorts-deflector" "shortsdeflector@addons.com"
    // NewExt "hide-youtube-shorts" "{88ebde3a-4581-4c6b-8019-2a05a9e3e938}"
    // NewExt "proton-pass" "78272b6fa58f4a1abaac99321d503a20@proton.me"
    // NewExt "darkreader" "addon@darkreader.org"
    // NewExt "styl-us" "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}"
    // {
      "*".installation_mode = "blocked";
    };

  # Configure Firefox suggest
  SearchSuggestEnabled = false;
  FirefoxSuggest = {
    WebSuggestions = true;
    SponsoredSuggestions = false;
    ImproveSuggest = false;
    Locked = true;
  };

  # Configure Search engines
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

  # Configure Bookmarks
  # Use the provided template to add your preferred Bookmarks
  NoDefaultBookmarks = true;
  Bookmarks = [
    #{
    #  Title = "";
    #  URL = "";
    #  Favicon = "";
    #  Placement = "";
    #  Folder = "";
    #}
  ];

  # Privacy settings
  DisableTelemetry = true;
  HttpsOnlyMode = "enabled";
  PostQuantumKeyAgreementEnabled = true;
  EnableTrackingProtection = {
    Value = true;
    Locked = true;
    Cryptomining = true;
    Fingerprinting = true;
    EmailTracking = true;
    Category = "strict";
  };

  # Clear browsing data when closing the browser
  SanitizeOnShutdown = {
    Cache = true;
    Cookies = false;
    FormData = true;
    History = true;
    Sessions = true;
    SiteSettings = false;
    Locked = true;
  };

  # Configure Mozilla Account feature
  DisableAccounts = true;
  DisableFirefoxAccounts = true;

  # Configure Master Password feature, "DisableMasterPwd" takes precedent ;
  # Setting PrimaryPassword to true REQUIRES a master password whereas
  # setting DisableMasterPasswordCreation to false ALLOWS a master password
  DisableMasterPasswordCreation = true;
  PrimaryPassword = false;
  PasswordManagerEnabled = false;
  # Setting PasswordManagerEnabled to false disables the two following :
  # OfferToSaveLogins = false;          This locks the preference whereas
  # OfferToSaveLoginsDefault = false;   this one does not lock it
  DisablePasswordReveal = true;

  # Configure Forms and Autofills
  AutofillAddressEnabled = false;
  AutofillCreditCardEnabled = false;
  DisableFormHistory = true;

  # Disable certain features
  DisableFeedbackCommands = true;
  DisableFirefoxScreenshots = true;
  DisableFirefoxStudies = true;
  DisablePrivateBrowsing = false;
  DisablePocket = true;
  DisableSetDesktopBackground = true;
  TranslateEnabled = false;

  # Configure some miscellaneous behavior
  DisableSystemAddonUpdate = true;
  HardwareAcceleration = true;
  # Downloads behavior
  # DefaultDownloadDirectory = "${home}"; not needed if Prompt... is enabled
  PromptForDownloadLocation = true;
  # Enable Picture-in-Picture
  PictureInPicture.Enabled = true;
  PictureInPicture.Locked = true;
  # DNS Prefetching
  NetworkPrediction = true;
  # Skip unnecessary things
  DontCheckDefaultBrowser = true;
  OverrideFirstRunPage = "";
  SkipTermsOfUse = true;

  # Configure appearance of the browser
  DisplayBookmarksToolbar = "newtab";
  DisplayMenuBar = "default-off";
  SearchBar = "unified";
  ShowHomeButton = false;

  # Configure the homepage
  NewTabPage = true;
  Homepage = {
    URL = "about:home";
    Locked = true;
    StartPage = "homepage-locked";
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

  # App update behavior
  DisableAppUpdate = true;
  OverridePostUpdatePage = "";

  # Printing behavior
  PrintingEnabled = true;
  UseSystemPrintDialog = false;
}
