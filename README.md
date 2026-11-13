# Dotfiles Arch Linux · Hyprland · Ghost Pastel

Configuration de mon poste **Arch Linux** sous **Hyprland** (config Lua),
harmonisée avec le thème **[Ghost Pastel](https://omarchytheme.com/themes/ghost-pastel)**
repris d'Omarchy. Police unique : **Hack Nerd Font**.

> Ce dépôt a d'abord servi sur Gentoo (oct.–nov. 2026) : les fichiers Portage, dracut,
> SDDM, rofi, mako, ghostty et herdr sont dans l'historique Git.

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
| `home/` | `~/` | `.bashrc` (alias `up`/`clean`/`ins` avec yay), `.gtkrc-2.0` |
| `config/hypr/` | `~/.config/hypr/` | Hyprland (config Lua, layout dwindle), hyprlock (capture du bureau floutée), hypridle, hyprpaper |
| `config/waybar/` | `~/.config/waybar/` | Barre (disposition Omarchy) + menu d'alimentation wofi |
| `config/dunst/` | `~/.config/dunst/` | Notifications (thème Ghost, repris de mako) |
| `config/wofi/` | `~/.config/wofi/` | Lanceur (`Super+Espace`) + thème Ghost (`style.css`) |
| `config/kitty/` | `~/.config/kitty/` | Terminal + thème `ghost.conf` |
| `config/btop/` | `~/.config/btop/` | Moniteur système + thème Ghost |
| `config/yazi/` | `~/.config/yazi/` | Gestionnaire de fichiers + flavor `ghost.yazi` |
| `config/fastfetch/` | `~/.config/fastfetch/` | Logo Arch |
| `config/nvim/` | `~/.config/nvim/` | LazyVim |
| `config/zed/` | `~/.config/zed/` | Éditeur Zed + thème `themes/ghost.json` |
| `config/starship.toml` | `~/.config/` | Prompt + profil `claude-code` (status line de Claude Code) |
| `claude/statusline.sh` | `~/.claude/` | Status line de Claude Code : starship + niveau d'effort |
| `config/git/` | `~/.config/git/` | Alias et réglages Git (section `[user]` retirée) |
| `config/gtk-3.0/`, `config/gtk-4.0/` | `~/.config/` | Couleurs Ghost pour libadwaita (GTK4) et adw-gtk3 (GTK3) |
| `config/kdeglobals`, `dolphinrc` | `~/.config/` | Dolphin en Ghost |
| `config/mimeapps.list` | `~/.config/` | Firefox par défaut |
| `config/environment.d/` | `~/.config/` | `SSH_AUTH_SOCK` pour l'agent SSH de systemd |
| `config/fontconfig/` | `~/.config/fontconfig/` | Réglages de polices |
| `local/bin/arch-aide` | `~/.local/bin/` | Aide-mémoire des commandes pacman/yay (`Super+K`) |
| `local/share/color-schemes/Ghost.colors` | `~/.local/share/color-schemes/` | Jeu de couleurs KDE |
| `wallpapers/` | `~/Pictures/` | Fonds d'écran (celui utilisé est défini dans `hyprpaper.conf`) |

## Installation

Paquets (dépôts officiels + AUR via `yay`) :

```sh
sudo pacman -S --needed hyprland hyprlock hypridle hyprpaper hyprpolkitagent hyprshot dunst \
  xdg-desktop-portal-hyprland xdg-desktop-portal-gtk waybar wofi kitty btop yazi fastfetch \
  neovim zed zoxide eza lazygit jq wl-clipboard grim slurp playerctl libnotify \
  pipewire pipewire-pulse wireplumber kwallet kwallet-pam dolphin ark firefox \
  adw-gtk-theme ttf-hack-nerd tuned ly
yay -S kdrive-bin
```

starship s'installe avec le script officiel (`/usr/local/bin/starship`).

Fichiers utilisateur :

```sh
cp -r home/. ~/
cp -r config/. ~/.config/
cp -r local/. ~/.local/
cp -r claude/. ~/.claude/
cp wallpapers/* ~/Pictures/
```

Services :

```sh
sudo systemctl enable ly@tty1.service
sudo systemctl enable --now tuned
sudo tuned-adm profile throughput-performance
systemctl --user enable --now ssh-agent.socket
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
```

## Session

- Connexion par **Ly** (`ly@tty1`). Son fichier PAM (`/etc/pam.d/ly`) appelle déjà
  `pam_kwallet5` : avec `kwallet-pam` installé, KWallet est déverrouillé au login
  (kDrive y garde son jeton) une fois que `pam_kwallet_init` (lancé par `hyprland.lua`)
  lui a transmis l'environnement de la session. Sa sortie va dans le journal :
  `journalctl -b -t pam_kwallet_init`. kDrive attend que `org.freedesktop.secrets`
  soit disponible avant de démarrer. Ne pas installer `gnome-keyring` en parallèle : les deux
  se disputent `org.freedesktop.secrets` et kDrive perd sa connexion.
- Hyprland ne lit pas `~/.config/autostart` : tout est lancé depuis le bloc
  `hyprland.start` de `hyprland.lua` (Waybar, hyprpaper, hypridle, hyprpolkitagent,
  `pam_kwallet_init`, kDrive).
- Notifications : **dunst** (activé par D-Bus, thème Ghost dans `config/dunst/dunstrc`).
- `~/.local/bin` n'est pas dans le `PATH` de Hyprland ni de Waybar : chemins complets
  dans les raccourcis et modules.
- Raccourcis de workspaces en keycodes (`code:10`…`code:14`) pour fonctionner en AZERTY.

## Thème GTK

`gtk.css` redéfinit les couleurs nommées de libadwaita (variables CSS `--accent-bg-color`…
en GTK4, `@define-color` en GTK3). En GTK3, seul le thème **adw-gtk3** (`adw-gtk-theme`)
lit ces couleurs. Les applis Qt hors KDE gardent leur style par défaut (pas de
`plasma-integration`).

## Captures d'écran

Avec `hyprshot`. Chaque capture est enregistrée dans `~/Pictures/Screenshots`
et copiée dans le presse-papier.

| Raccourci | Capture |
|---|---|
| `Super+Ctrl+S` | Zone à sélectionner |
| `Super+Ctrl+W` | Fenêtre |
| `Super+Ctrl+F` | Écran entier |

## Aide-mémoire Arch

`Super+K` ouvre une popup wofi qui liste les commandes du quotidien : mise à jour
du système, nettoyage, installation et suppression d'un logiciel. Rien n'est
exécuté : `Entrée` copie seulement la commande choisie dans le presse-papier
(`wl-copy`), `Échap` ferme la popup. La liste se modifie en haut du script
`arch-aide` (format `commande|description`, `# Titre` pour une section).

## Verrouillage automatique

`hypridle` verrouille l'écran avec hyprlock après **5 min** d'inactivité et
l'éteint après **30 min**. Il verrouille aussi avant une mise en veille.

Le bouton `idle_inhibitor` de la Waybar (à gauche du bouton d'alimentation) le met en pause :
cadenas gris = verrouillage actif, tasse violette = désactivé (pour lire, regarder
une vidéo…). Il revient à « actif » à chaque nouvelle session.

## Status line de Claude Code

`claude/statusline.sh` extrait le niveau d'effort du JSON envoyé par Claude Code
(starship ne l'affiche pas) puis appelle `starship statusline claude-code`.
Rendu : `on 🤖 Opus 5.5 · high  ███░░░░░░░ 31%`, jauge violette, rose dès 70 %,
rouge dès 90 %. Nécessite `jq`. Dans `~/.claude/settings.json` :

```json
"statusLine": { "type": "command", "command": "~/.claude/statusline.sh" }
```
