import os

# Index:
# - ANDROID_PKGS
# - APPS_PKGS
# - COMMS_AND_NETWORKING_PKGS
# - DEVELOPMENT_PKGS
# - DOCUMENTS_AND_MEDIA_PKGS
# - ELECTRONICS_PKGS
# - FONT_PKGS
# - GAMING_PKGS
# - JAVA_PKGS
# - MISC_PKGS
# - PYTHON_PKGS
# - SHELL_PKGS
# - SWAY_PKGS
# - SYSTEM_AND_LIBS_PKGS

SYSTEM_AND_LIBS_PKGS = [
    "aur/libffi6",
    "core/linux-lts",
    "core/linux-lts-headers",
]

SWAY_PKGS = [
    "aur/brillo",
    "community/grim",
    "community/ponymix",
    "community/sway",
    "aur/swaylock-effects-git",
    "community/rofi",
    "community/slurp",
    "aur/wdisplays",
    "aur/wev",
    "community/wl-clipboard",
    "aur/wofi",
    "extra/xfce4-notifyd",
]

APPS_PKGS = [
    "aur/alacritty-ligatures",
    "community/anki",
    "aur/chromium-snapshot-bin",
    "community/filezilla",
    "extra/firefox",
    "extra/gedit",
    "extra/gnome-font-viewer",
    "extra/gvim",
    "community/kicad",
    "community/kicad-library",
    "aur/sparkfun-kicad-lib-git",
    "community/mupdf",
    "community/termite",
    "aur/visual-studio-code-bin",
    "extra/vlc",
    "community/zathura",
    "community/zathura-pdf-mupdf",
    "aur/zoom",
]

COMMS_AND_NETWORKING_PKGS = [
    "community/blueman",
    "extra/bluez",
    "extra/bluez-utils",
    "community/httpie",
    "extra/libmicrodns",
    "extra/mtr",
    "aur/networkmanager-dispatcher-timesyncd",
    "aur/ngrok",
    "aur/openvpn-update-systemd-resolved",
    "core/traceroute",
]

SHELL_PKGS = [
    "extra/bash-completion",
    "community/bat",
    "aur/cht.sh",
    "community/colordiff",
    "aur/direnv",
    "endeavouros/downgrade",
    "aur/downgrader-git",
    "community/fd",
    "community/fzf",
    "community/fzy",
    "community/jq",
    "extra/libqalculate",
    "community/moreutils",
    "extra/p7zip",
    "community/ripgrep",
    "extra/screen",
    "community/sl",
    "community/tldr",
    "community/tmux",
    "extra/tree",
    "aur/universal-ctags-git",
]

DEVELOPMENT_PKGS = [
    "community/aws-cli",
    "aur/awslogs",
    "community/ccache",
    "aur/ccls",
    "community/cloc",
    "community/docker",
    "community/docker-compose",
    "aur/flow-bin",
    "aur/gopls",
    "community/leiningen",
    "community/libmemcached",
    "community/npm",
    "extra/strace",
    "community/terraform",
    "aur/tflint-bin",
    "aur/vscode-html-languageserver-bin",
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
    "community/arduino-cli",
    "aur/esp-idf",
    "community/esptool",
    "community/picocom",
    "community/python-pyudev",
    "aur/rshell",
]

DOCUMENTS_AND_MEDIA_PKGS = [
    "extra/graphviz",
    "community/pandoc",
    "aur/python-grip",
    "community/youtube-dl",
]

ANDROID_PKGS = [
    "community/android-tools",
    "aur/flutter",
    "aur/scrcpy",
]

MISC_PKGS = [
    "aur/imgur.sh",
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

GAMING_PKGS = [
    "multilib/lib32-mesa",
    "vulkan-mesa-layers",
    "aur/proton",
    "multilib/steam",
    "aur/vkd3d-valve",
    "extra/vulkan-intel",
    "multilib/wine",
]

PACKAGES = (
    SYSTEM_AND_LIBS_PKGS
    + SWAY_PKGS
    + SHELL_PKGS
    + APPS_PKGS
    + COMMS_AND_NETWORKING_PKGS
    + DOCUMENTS_AND_MEDIA_PKGS
    + DEVELOPMENT_PKGS
    + PYTHON_PKGS
    + JAVA_PKGS
    + ELECTRONICS_PKGS
    + ANDROID_PKGS
    + MISC_PKGS
    + FONT_PKGS
    + GAMING_PKGS
)


def install(packages):
    pkgs = " ".join(packages)
    os.system(f"yay -S --needed {pkgs}")


if __name__ == "__main__":
    install(PACKAGES)
