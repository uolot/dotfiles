import os


PACKAGES = [
    # System
    "aur/openvpn-update-systemd-resolved",
    # Sway
    "aur/brillo",
    "community/ponymix",
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
    "community/tmux",
    "extra/tree",
    "aur/universal-ctags-git",
    "community/wl-clipboard",
    # Dev
    "community/aws-cli",
    "aur/awslogs",
    "community/ccache",
    "community/docker",
    "community/docker-compose",
    "community/libmemcached",
    "community/terraform",
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
