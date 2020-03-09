import os


PACKAGES = [
    # Sway
    "aur/brillo",
    "community/grim",
    "community/ponymix",
    "community/sway",
    "aur/swaylock-effects-git",
    "community/rofi",
    "community/slurp",
    "community/wl-clipboard",
    # Apps
    "aur/chromium-snapshot-bin",
    "community/filezilla",
    "extra/firefox",
    "extra/gnome-font-viewer",
    "extra/gvim",
    "community/mupdf",
    "community/termite",
    "community/zathura",
    "community/zathura-pdf-mupdf",
    # Communication
    "community/blueman",
    "extra/bluez",
    "extra/bluez-utils",
    "aur/openvpn-update-systemd-resolved",
    # Shell
    "extra/bash-completion",
    "community/colordiff",
    "aur/direnv",
    "community/fd",
    "community/fzf",
    "community/fzy",
    "community/jq",
    "extra/libqalculate",
    "community/moreutils",
    "community/ripgrep",
    "extra/screen",
    "community/tldr",
    "community/tmux",
    "extra/tree",
    "aur/universal-ctags-git",
    # Dev
    "community/aws-cli",
    "aur/awslogs",
    "community/ccache",
    "community/docker",
    "community/docker-compose",
    "community/libmemcached",
    "community/npm",
    "extra/strace",
    "community/terraform",
    # Python
    "community/ipython",
    "community/mypy",
    "community/pylama",
    "community/pyenv",
    "community/python-black",
    "extra/python-cffi",
    "community/python-language-server",
    "extra/python-pip",
    "aur/python-pipx",
    "community/python-poetry",
    "community/python-pudb",
    "community/python-pygame",
    "extra/python-setuptools",
    "extra/python-virtualenv",
    # Java
    "extra/jdk-openjdk",
    "community/maven",
    # EE
    "aur/adafruit-ampy",
    "community/arduino",
    "aur/esp-idf",
    "community/esptool",
    "community/picocom",
    "community/python-pyudev",
    "aur/rshell",
    # Android
    "community/android-tools",
    "aur/scrcpy",
    # Misc and utils
    "community/imv",
    "extra/snappy",
    "community/sox",
    "extra/tk",
    # Fonts
    "community/otf-font-awesome",
    "aur/ttf-input",
]


def install(packages):
    pkgs = " ".join(packages)
    os.system(f"yay -S --needed {pkgs}")


if __name__ == "__main__":
    install(PACKAGES)
