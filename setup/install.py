import os
from lib import ask

# Index:
# 1. ANDROID_PKGS
# 2. APPS_PKGS
# 3. COMMS_AND_NETWORKING_PKGS
# 4. DEVELOPMENT_PKGS
# 5. DOCUMENTS_AND_MEDIA_PKGS
# 6. ELECTRONICS_PKGS
# 7. FONT_PKGS
# 8. GAMING_PKGS
# 9. JAVA_PKGS
# 10. KEYBOARD_PKGS
# 11. KUBERNETES_PKGS
# 12. MISC_PKGS
# 13. PRINTER_PKGS
# 14. PYTHON_PKGS
# 15. SDR_PKGS
# 16. SHELL_PKGS
# 17. SWAY_PKGS
# 18. SYSTEM_AND_LIBS_PKGS

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
    "community/swayidle",
    "aur/swaylock-effects-git",
    "community/slurp",
    "aur/wdisplays-git",
    # "aur/wev",
    "aur/wev-git",
    "community/wl-clipboard",
    "aur/wofi",
    "extra/xfce4-notifyd",  # TODO: remove
    "aur/ydotool-git",
]

APPS_PKGS = [
    "aur/alacritty-ligatures",
    "community/audacity",
    "aur/chrome-remote-desktop",
    "aur/chromium-snapshot-bin",
    "aur/etcher-bin",
    "extra/firefox",
    "extra/gimp",
    "extra/gnome-font-viewer",
    "aur/google-chrome",
    "extra/gvim",
    # "community/kicad",
    # "community/kicad-library",
    # "aur/sparkfun-kicad-lib-git",
    "community/mupdf",
    "extra/nautilus",
    "extra/vlc",
    "community/zathura",
    "community/zathura-pdf-mupdf",
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
    "aur/dollar",
    "endeavouros/downgrade",
    "aur/downgrader-git",
    "community/fd",
    "community/fzf",
    "community/fzy",
    "aur/glow-bin",
    "aur/gotty-bin",
    "community/inotify-tools",
    "community/jq",
    "extra/libqalculate",
    "community/moreutils",
    "extra/p7zip",
    "community/python-html2text",
    "community/ripgrep",
    "extra/screen",
    "aur/shellcheck-bin",
    "community/sl",
    "community/tldr",
    "community/tmux",
    "extra/tree",
    "aur/ttyd",
    "aur/universal-ctags-git",
]

DEVELOPMENT_PKGS = [
    "community/aws-cli",
    "aur/awslogs",
    # "community/ccache",
    "aur/ccls",
    "community/cloc",
    "community/docker",
    "community/docker-compose",
    "aur/flow-bin",  # type checker for JS
    "aur/git-delta",
    "aur/google-cloud-sdk",
    "aur/gopls",  # Go language server
    "aur/javascript-typescript-langserver",
    "community/leiningen",
    "community/libmemcached",
    "community/nim",
    "community/npm",
    "community/pgadmin4",
    "extra/postgresql",
    "aur/postman6-bin",
    "community/redis",
    "aur/sqlfluff",
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
    "aur/python38",
    "extra/python-cffi",
    "community/python-pre-commit",
    "community/python-language-server",
    "extra/python-pip",
    "community/python-poetry",
    "community/python-pygame",
    "community/python-pynvim",
    "extra/python-setuptools",
    "extra/python-virtualenv",
]

JAVA_PKGS = [
    "aur/jdk-adoptopenjdk",
    "extra/jdk-openjdk",
    "aur/jdk11-adoptopenjdk",
    "community/maven",
]

ELECTRONICS_PKGS = [
    "aur/adafruit-ampy",
    "community/arduino",
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
    "community/otf-font-awesome",
    "aur/ttf-go-mono-git",
    "aur/ttf-input",
]

GAMING_PKGS = [
    "multilib/lib32-mesa",
    # "vulkan-mesa-layers",
    # "aur/proton",
    # "multilib/steam",
    # "aur/vkd3d-valve",
    # "extra/vulkan-intel",
    "multilib/wine",
]

SDR_PKGS = [
    # "aur/gnss-sdr-git",
    # "community/gqrx",
    # "community/inspectrum",
    # "aur/sdrsharp",
]

KEYBOARD_PKGS = [
    # "aur/interception-caps2esc-nocaps-git",
    # "aur/interception-dual-function-keys",
    "community/qmk",
    "aur/zsa-wally-bin",
    "aur/zsa-wally-cli-bin",
]

KUBERNETES_PKGS = [
    "kubernetes-tools",
    #
    "aur/kind-bin",
    "aur/minikube-bin",
]

PRINTER_PKGS = [
    "extra/cups-pdf",
    "extra/cups-pk-helper",
    "extra/foomatic-db",
    "extra/foomatic-db-nonfree-ppds",
    "extra/foomatic-db-nonfree",
    "extra/foomatic-db-ppds",
    "extra/system-config-printer",
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
    "kubernetes": KUBERNETES_PKGS,
    "printer": PRINTER_PKGS,
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
