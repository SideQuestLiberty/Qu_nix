# Qu_nix
Side **Qu**estLiberty's **Nix**OS (I know it feels cryptic seen like that, but it has some private implications behind).

This project is still in its very early stage (I created it on June 11, 2025 - right before exams, as a way to procrastinate studying. I got 87,5%.).
I have more plans for the near future, notably including configuration of all the software installed, and developing my own desktop widgets using [outfoxxed's quickshell](https://quickshell.org/) (No barab., I won't use [AGS](https://aylur.github.io/ags/), I want to try out other things.).
## How to install:
1. Clone this repository
2. Replace `Qu_nix/NixOS/hardware-configuration.nix` with your own (by default at `/etc/nixos/hardware-configuration.nix`)
3. Edit `Qu_nix/flake.nix` to your liking
4. When rebuilding for the first time:
```
sudo nixos-rebuild boot --flake /path/to/Qu_nix/#yourhostname; reboot
```
5. When rebuilding after that, given you did **not** change your hostname _AND_ the `/path/to/Qu_nix` _AND_ shell aliases, and you filled `/Qu_nix/flake.nix` accordingly:
```
rebuild
```
## Contributing
If you find a bug or security issue, please create a pull request or issue, or let me know by any other mean you find.

You can create pull requests if you feel like improving my code, I'm unknown enough to have the time to review them individually.
I usually try to keep lines shorter than 80 caracters, which explains some of my weird indentation.
Please try to use your common sense and keep the "artistic direction" I tend towards.
Please know that I won't "add this package" or "remove this option" because it is specifically tailored for my usage.
