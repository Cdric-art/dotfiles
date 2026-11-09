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
| `config/waybar/` | `~/.config/waybar/` | Barre (disposition Omarchy) + menu power rofi + bouton Herdr (focus ou lancement) |
| `config/rofi/` | `~/.config/rofi/` | Lanceur + thème `ghost.rasi` |
| `config/mako/` | `~/.config/mako/` | Notifications |
| `config/ghostty/` | `~/.config/ghostty/` | Terminal secondaire + thème `themes/Ghost` |
| `config/herdr-app/` | `~/.config/herdr-app/` | herdr (app) : réglages + thème `themes/ghost.json` |
| `config/kitty/` | `~/.config/kitty/` | Terminal par défaut + thème `ghost.conf` |
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
| `local/bin/gentoo-aide` | `~/.local/bin/` | Aide-mémoire des commandes Gentoo (`Super+K`) |
| `local/share/color-schemes/Ghost.colors` | `~/.local/share/color-schemes/` | Jeu de couleurs KDE |
| `local/share/org.kde.syntax-highlighting/themes/ghost.theme` | `~/.local/share/…` | Thème de l'éditeur Kate |
| `icons/default/index.theme` | `~/.icons/default/` | Curseur Breeze partout |
| `wallpapers/` | `~/Pictures/` | Fonds d'écran (celui utilisé est défini dans `hyprpaper.conf`) |
| `system/etc/portage/` | `/etc/portage/` | `make.conf`, `package.*`, dépôts (guru, hyproverlay), binhost |
| `home/.bash_profile` | `~/` | Lance Hyprland après le login sur le tty1 |
| `system/etc/pam.d/login` | `/etc/pam.d/` | KWallet déverrouillé au login tty (`force_run`) |
| `system/etc/systemd/system/getty@tty1.service.d/` | `/etc/systemd/system/` | Invite de login propre sur le tty1 |
| `system/etc/dracut.conf.d/10-nvidia-drivers.conf` | `/etc/dracut.conf.d/` | Driver NVIDIA dans l'initramfs (early KMS) |
| `system/etc/kernel/cmdline` | `/etc/kernel/` | Options du noyau (UUID racine à adapter) |

## Installation

Fichiers utilisateur :

```sh
cp -r home/. ~/
cp -r config/. ~/.config/
cp -r local/. ~/.local/
cp -r icons/. ~/.icons/
cp wallpapers/* ~/Pictures/
```

Fichiers système (relire avant de copier, surtout `make.conf`, `kernel/cmdline` et `pam.d/`) :

```sh
sudo cp -r system/etc/. /etc/
```

## Paquets principaux

Hyprland (`gui-wm/hyprland`, dépôt hyproverlay), `hyprlock`, `hypridle`, `hyprpaper`,
`hyprpolkitagent`, `xdg-desktop-portal-hyprland`, `waybar` (USE `tray network mpris`),
`rofi-wayland`, `mako`, `hyprshot` (captures, avec `grim` et `slurp`), `ghostty`, `kitty`, `btop`, `yazi`, `fastfetch`, `starship`, `zoxide`, `eza`,
`neovim`, `zed`, PipeWire/WirePlumber, KWallet (`kwallet-pam`), Breeze
(curseur, `breeze-gtk`, `plasma-integration`), Dolphin, Kate, Okular, Firefox.

Polices : Fira Code, Geist, Symbols Nerd Font, Noto.

## Connexion sans SDDM

Pas de gestionnaire de connexion (SDDM retiré) : on se connecte sur le tty1
et `~/.bash_profile` lance `start-hyprland`. Les autres ttys restent des shells normaux (`Ctrl+Alt+F2`),
pratiques si Hyprland ne démarre pas.

- `pam_kwallet5` est ajouté dans `/etc/pam.d/login` avec `force_run`, sinon il
  ignore les sessions tty (« not a graphical session ») et KWallet reste verrouillé.
- Pour éviter les clignotements de l'invite, le driver NVIDIA est chargé dès
  l'initramfs (fichier dracut du même nom que celui de Gentoo, qui l'exclut) et
  `fbcon=nodefer` fait basculer la console avant getty. Après une modification :
  `sudo emerge --config sys-kernel/gentoo-kernel`.
- Lors d'une mise à jour, garder sa version de `/etc/pam.d/login` (supprimer le `._cfg*`).

## Captures d'écran

Avec `hyprshot`. Chaque capture est enregistrée dans `~/Pictures/Screenshots`
et copiée dans le presse-papier.

| Raccourci | Capture |
|---|---|
| `Super+Ctrl+S` | Zone à sélectionner |
| `Super+Ctrl+W` | Fenêtre |
| `Super+Ctrl+F` | Écran entier |

## Aide-mémoire Gentoo

`Super+K` ouvre une popup rofi qui liste les commandes du quotidien : mise à jour
du système, nettoyage, installation et suppression d'un logiciel. Rien n'est
exécuté : `Entrée` copie seulement la commande choisie dans le presse-papier
(`wl-copy`), `Échap` ferme la popup. La liste se modifie en haut du script
`gentoo-aide` (format `commande|description`, `# Titre` pour une section).

## Verrouillage automatique

`hypridle` verrouille l'écran avec hyprlock après **5 min** d'inactivité et
l'éteint après **30 min**. Il verrouille aussi avant une mise en veille.

Le bouton à droite de l'heure dans la Waybar (`idle_inhibitor`) le met en pause :
cadenas gris = verrouillage actif, tasse violette = désactivé (pour lire, regarder
une vidéo…). Il revient à « actif » à chaque nouvelle session.

## Notes

- **Plasma a été retiré**, mais certains paquets KDE sont gardés volontairement (voir `world`) :
  `kwallet-pam`, `breeze`, `breeze-gtk`, `plasma-integration`.
- `package.use/notification-daemon` (`-kde`) empêche `plasma-workspace` de revenir ;
  `package.use/zlib` garde `minizip`, requis par `assimp` hors du profil plasma.
- `QT_QPA_PLATFORMTHEME=kde` (dans `hyprland.lua`) permet aux applis Qt de lire `kdeglobals`.
- Hyprland ne lit pas `~/.config/autostart` : tout est lancé depuis le bloc `hyprland.start`
  de `hyprland.lua` (Waybar, hyprpaper, mako, polkit, `pam_kwallet_init`, kDrive).
- Chemins à adapter : AppImage kDrive dans `hyprland.lua`, `icon-path` dans `mako/config`.
