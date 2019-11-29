import os


PACKAGES = [
    # System
    "aur/openvpn-update-systemd-resolved",
    # Sway
    "community/sway",
    "aur/swaylock-effects-git",
    "community/rofi",
    # Fonts
    "community/otf-font-awesome",
    "aur/ttf-input",
    # Shell
    "community/fd",
    "community/fzf",
    "community/fzy",
    "extra/libqalculate",
    "community/moreutils",
    "extra/tree",
    "aur/universal-ctags-git",
    "community/wl-clipboard",
    # Dev
    "community/ccache",
    "community/libmemcached",
    # Python
    "community/ipython",
    "community/mypy",
    "community/pylama",
    "community/pyenv",
    "community/python-black",
    "extra/python-cffi",
    "community/python-language-server",
    "community/python-poetry",
]


def install(packages):
    pkgs = " ".join(packages)
    os.system(f"yay -S --needed {pkgs}")


if __name__ == "__main__":
    install(PACKAGES)
