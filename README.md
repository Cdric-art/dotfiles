# Dotfiles Gentoo · Hyprland · Ghost Pastel

Configuration de mon poste Gentoo (profil `default/linux/amd64/23.0/desktop/systemd`)
sous **Hyprland**, harmonisée avec le thème **[Ghost Pastel](https://omarchytheme.com/themes/ghost-pastel)**
repris d'Omarchy.

## Palette

| Rôle | Couleur |
|---|---|
| Fond | `#070506` |
| Surfaces | `#120e10` · `#1a1418` · `#2a2228` |
| Texte | `#ffffff` |
| Texte secondaire | `#836f79` |
| Accent | `#979fec` |
| Bleu / cyan | `#648ed0` · `#7c93dd` |
| Rouge / rose / magenta | `#b37580` · `#e095b5` · `#cd9dcf` |

## Contenu

| Dossier du dépôt | Destination | Contenu |
|---|---|---|
| `home/` | `~/` | `.bashrc`, `.bash_profile`, `.gtkrc-2.0` |
| `config/hypr/` | `~/.config/hypr/` | Hyprland (config Lua), hyprlock (capture du bureau floutée), hypridle, hyprpaper |
| `config/waybar/` | `~/.config/waybar/` | Barre (disposition Omarchy) + menu power rofi |
| `config/rofi/` | `~/.config/rofi/` | Lanceur + thème `ghost.rasi` |
| `config/mako/` | `~/.config/mako/` | Notifications |
| `config/kitty/` | `~/.config/kitty/` | Terminal + thème `ghost.conf` |
| `config/btop/` | `~/.config/btop/` | Moniteur système + thème Ghost |
| `config/yazi/` | `~/.config/yazi/` | Gestionnaire de fichiers + flavor `ghost.yazi` |
| `config/fastfetch/` | `~/.config/fastfetch/` | Logo Gentoo |
| `config/nvim/` | `~/.config/nvim/` | LazyVim |
| `config/zed/` | `~/.config/zed/` | Éditeur Zed |
| `config/starship.toml` | `~/.config/` | Prompt |
| `config/git/` | `~/.config/git/` | Alias et réglages Git (section `[user]` retirée) |
| `config/gtk-3.0/`, `config/gtk-4.0/` | `~/.config/` | Breeze GTK recoloré en Ghost (`colors.css`, boutons de fenêtre) |
| `config/kdeglobals`, `katerc`, `dolphinrc`, `okularrc` | `~/.config/` | Applis KDE en Ghost |
| `config/mimeapps.list` | `~/.config/` | Firefox par défaut |
| `config/environment.d/`, `config/systemd/user/` | `~/.config/` | Agent SSH en service utilisateur |
| `config/fontconfig/` | `~/.config/fontconfig/` | Réglages de polices |
| `local/share/color-schemes/Ghost.colors` | `~/.local/share/color-schemes/` | Jeu de couleurs KDE |
| `local/share/org.kde.syntax-highlighting/themes/ghost.theme` | `~/.local/share/…` | Thème de l'éditeur Kate |
| `icons/default/index.theme` | `~/.icons/default/` | Curseur Breeze partout |
| `wallpapers/` | `~/Pictures/` | Un fond d'écran Ghost (à adapter dans `hyprpaper.conf`) |
| `system/etc/portage/` | `/etc/portage/` | `make.conf`, `package.*`, dépôts (guru, hyproverlay), binhost |
| `system/etc/sddm.conf.d/zz-ghost.conf` | `/etc/sddm.conf.d/` | Thème SDDM + curseur |
| `system/etc/pam.d/sddm` | `/etc/pam.d/` | KWallet déverrouillé au login (GNOME Keyring désactivé) |
| `system/usr/share/sddm/themes/ghost/` | `/usr/share/sddm/themes/` | Thème SDDM Ghost (QML, fond noir uni) |

## Installation

Fichiers utilisateur :

```sh
cp -r home/. ~/
cp -r config/. ~/.config/
cp -r local/. ~/.local/
cp -r icons/. ~/.icons/
cp wallpapers/* ~/Pictures/
```

Fichiers système (relire avant de copier, surtout `make.conf` et `pam.d/sddm`) :

```sh
sudo cp -r system/etc/. /etc/
sudo cp -r system/usr/. /usr/
```

## Paquets principaux

Hyprland (`gui-wm/hyprland`, dépôt hyproverlay), `hyprlock`, `hypridle`, `hyprpaper`,
`hyprpolkitagent`, `xdg-desktop-portal-hyprland`, `waybar` (USE `tray network mpris`),
`rofi-wayland`, `mako`, `hyprshot` (captures, avec `grim` et `slurp`), `kitty`, `btop`, `yazi`, `fastfetch`, `starship`, `zoxide`, `eza`,
`neovim`, `zed`, SDDM, PipeWire/WirePlumber, KWallet (`kwallet-pam`), Breeze
(curseur, `breeze-gtk`, `plasma-integration`), Dolphin, Kate, Okular, Firefox.

Polices : Fira Code, Geist, Symbols Nerd Font, Noto.

## Captures d'écran

Avec `hyprshot`. Chaque capture est enregistrée dans `~/Pictures/Screenshots`
et copiée dans le presse-papier.

| Raccourci | Capture |
|---|---|
| `Super+Ctrl+S` | Zone à sélectionner |
| `Super+Ctrl+W` | Fenêtre |
| `Super+Ctrl+F` | Écran entier |

## Verrouillage automatique

`hypridle` verrouille l'écran avec hyprlock après **5 min** d'inactivité et
l'éteint après **30 min**. Il verrouille aussi avant une mise en veille.

Le bouton à droite de l'heure dans la Waybar (`idle_inhibitor`) le met en pause :
cadenas gris = verrouillage actif, tasse violette = désactivé (pour lire, regarder
une vidéo…). Il revient à « actif » à chaque nouvelle session.

## Notes

- **Plasma a été retiré**, mais certains paquets KDE sont gardés volontairement (voir `world`) :
  `sddm`, `kwallet-pam`, `breeze`, `breeze-gtk`, `plasma-integration`.
- `package.use/notification-daemon` (`-kde`) empêche `plasma-workspace` de revenir ;
  `package.use/zlib` garde `minizip`, requis par `assimp` hors du profil plasma.
- `QT_QPA_PLATFORMTHEME=kde` (dans `hyprland.lua`) permet aux applis Qt de lire `kdeglobals`.
- Hyprland ne lit pas `~/.config/autostart` : tout est lancé depuis le bloc `hyprland.start`
  de `hyprland.lua` (Waybar, hyprpaper, mako, polkit, `pam_kwallet_init`, kDrive).
- Chemins à adapter : AppImage kDrive dans `hyprland.lua`, `icon-path` dans `mako/config`.
