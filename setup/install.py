import os


SWAY_PKGS = [
    "aur/brillo",
    "community/grim",
    "community/ponymix",
    "community/sway",
    "aur/swaylock-effects-git",
    "community/rofi",
    "community/slurp",
    "community/wl-clipboard",
    "extra/xfce4-notifyd",
]

APPS_PKGS = [
    "aur/alacritty-ligatures",
    "aur/chromium-snapshot-bin",
    "community/filezilla",
    "extra/firefox",
    "extra/gnome-font-viewer",
    "extra/gvim",
    "community/mupdf",
    "community/termite",
    "community/zathura",
    "community/zathura-pdf-mupdf",
]

COMMS_AND_NETWORKING_PKGS = [
    "community/blueman",
    "extra/bluez",
    "extra/bluez-utils",
    "aur/openvpn-update-systemd-resolved",
]

SHELL_PKGS = [
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
]

DEVELOPMENT_PKGS = [
    "community/aws-cli",
    "aur/awslogs",
    "community/ccache",
    "community/docker",
    "community/docker-compose",
    "community/libmemcached",
    "community/npm",
    "extra/strace",
    "community/terraform",
]

PYTHON_PKGS = [
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
    "community/python-pynvim",
    "extra/python-setuptools",
    "extra/python-virtualenv",
]

JAVA_PKGS = [
    "extra/jdk-openjdk",
    "community/maven",
]


ELECTRONICS_PKGS = [
    "aur/adafruit-ampy",
    "community/arduino",
    "aur/esp-idf",
    "community/esptool",
    "community/picocom",
    "community/python-pyudev",
    "aur/rshell",
]

ANDROID_PKGS = [
    "community/android-tools",
    "aur/scrcpy",
]

MISC_PKGS = [
    "community/imv",
    "extra/snappy",
    "community/sox",
    "extra/tk",
]

FONT_PKGS = [
    "aur/ttf-anka-coder",
    "aur/ttf-anka-coder-condensed",
    "aur/font-victor-mono",
    "community/otf-font-awesome",
    "community/ttf-cascadia-code",
    "community/ttf-fira-code",
    "aur/ttf-input",
]

PACKAGES = (
    SWAY_PKGS
    + APPS_PKGS
    + COMMS_AND_NETWORKING_PKGS
    + SHELL_PKGS
    + DEVELOPMENT_PKGS
    + PYTHON_PKGS
    + JAVA_PKGS
    + ELECTRONICS_PKGS
    + ANDROID_PKGS
    + MISC_PKGS
    + FONT_PKGS
)


def install(packages):
    pkgs = " ".join(packages)
    os.system(f"yay -S --needed {pkgs}")


if __name__ == "__main__":
    install(PACKAGES)
