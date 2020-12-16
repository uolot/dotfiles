import os
from lib import ask

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
# - KEYBOARD_PKGS
# - MISC_PKGS
# - PYTHON_PKGS
# - SDR_PKGS
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
    "extra/libpipewire02",
    "community/playerctl",
    "community/python-i3ipc",
    "community/rofi",
    "community/sway",
    "aur/swaylock-effects-git",
    "community/slurp",
    "aur/wdisplays",
    "aur/wev",
    "community/wl-clipboard",
    "aur/wofi",
    "extra/xfce4-notifyd",
    "aur/ydotool-git",
]

APPS_PKGS = [
    "aur/alacritty-ligatures",
    "community/anki",
    "community/audacity",
    "aur/chromium-snapshot-bin",
    "community/filezilla",
    "extra/firefox",
    "extra/gedit",
    "extra/gimp",
    "extra/gnome-font-viewer",
    "aur/google-chrome",
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
    "aur/ookla-speedtest-bin",
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
    "aur/glow-bin",
    "community/inotify-tools",
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
    "community/zig",
]

PYTHON_PKGS = [
    "community/ipython",
    "community/mypy",
    "community/pylama",
    "community/pyenv",
    "aur/pyenv-virtualenv",
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
    "aur/platformio",
    "community/python-pyudev",
    "aur/rshell",
]

DOCUMENTS_AND_MEDIA_PKGS = [
    "extra/graphicsmagick",
    "extra/graphviz",
    "aur/pandoc-bin",
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
    "community/webfs",
]

FONT_PKGS = [
    "aur/ttf-anka-coder",
    "aur/ttf-anka-coder-condensed",
    "aur/font-victor-mono",
    "community/otf-font-awesome",
    "community/ttf-fira-code",
    "aur/ttf-go-mono-git",
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

SDR_PKGS = [
    "aur/gnss-sdr-git",
    "community/gqrx",
    "community/inspectrum",
    "aur/sdrsharp",
]

KEYBOARD_PKGS = [
    "aur/interception-caps2esc-nocaps-git",
    "aur/interception-dual-function-keys",
    "community/qmk",
    "aur/zsa-wally",
    "aur/zsa-wally-cli",
]

PACKAGES = {
    "system and libs": SYSTEM_AND_LIBS_PKGS,
    "sway": SWAY_PKGS,
    "shell": SHELL_PKGS,
    "apps": APPS_PKGS,
    "comms and networking": COMMS_AND_NETWORKING_PKGS,
    "documents and media": DOCUMENTS_AND_MEDIA_PKGS,
    "development": DEVELOPMENT_PKGS,
    "python": PYTHON_PKGS,
    "java": JAVA_PKGS,
    "electronics": ELECTRONICS_PKGS,
    "android": ANDROID_PKGS,
    "misc": MISC_PKGS,
    "font": FONT_PKGS,
    "gaming": GAMING_PKGS,
    "sdr": SDR_PKGS,
    "keyboard": KEYBOARD_PKGS,
}


def install(groups):
    for group_name, packages in groups.items():
        print(f"{group_name} packages:")
        for pkg in packages:
            p = pkg.split("/")[1]
            print(f"\t- {p}")
        if ask(f"Install {group_name} packages?"):
            yay_packages = " ".join(packages)
            print(f"yay -S --needed {yay_packages}")
            os.system(f"yay -S --needed {yay_packages}")
        print()


if __name__ == "__main__":
    install(PACKAGES)
