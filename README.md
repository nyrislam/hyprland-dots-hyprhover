## hyprhover

---

<details>
<img width="1920" height="1080" alt="изображение" src="https://github.com/user-attachments/assets/bcc3a368-2d6b-463a-87bf-cc670567df6c" />
<img width="1920" height="1080" alt="изображение" src="https://github.com/user-attachments/assets/b377dbca-096a-434a-abb3-14ac5e7852f9" />
</details>

---

- WM: Hyprland
- Bar: Waybar
- Notifications: swaync
- Launcher: wofi
- Wallpaper / Colors: swww + matugen
- GTK Themes: nwg-look + murrine
- Terminal: kitty + nerd fonts
- Shell: zsh + powerlevel10k

---

Required Packages Installation (Arch / Manjaro)

```bash
sudo pacman -Syu imagemagick bc kitty zsh git wget curl
# Nerd Fonts (for example Hack Nerd Font)
sudo pacman -S ttf-hack-nerd ttf-jetbrains-mono-nerd ttf-fira-code-nerd
# Additional packages for Hyprland and related utilities
sudo pacman -S hyprland waybar wofi swww nwg-look swaync
# Build dependencies if needed
sudo pacman -S base-devel
```
If you use another system (e.g., Debian/Ubuntu), the commands would be:

```bash
sudo apt update && sudo apt install imagemagick bc kitty zsh git wget curl fonts-hack-ttf
```
