import os

from lib import ask

# Index:
#  1. ANDROID_PKGS
#  2. APPS_PKGS
#  3. COMMS_AND_NETWORKING_PKGS
#  4. DATABASE_PKGS
#  5. DEVELOPMENT_PKGS
#  6. DOCUMENTS_AND_MEDIA_PKGS
#  7. ELECTRONICS_PKGS
#  8. FONT_PKGS
#  9. GAMING_PKGS
# 10. JAVA_PKGS
# 11. KEYBOARD_PKGS
# 12. KUBERNETES_PKGS
# 13. MEDIA_PKGS
# 14. MISC_PKGS
# 15. PRINTER_PKGS
# 16. PYTHON_PKGS
# 17. SDR_PKGS
# 18. SHELL_PKGS
# 19. SWAY_PKGS
# 20. SYSTEM_AND_LIBS_PKGS
# 21. JS_PACKAGES

SYSTEM_AND_LIBS_PKGS = [
    "aur/libffi6",
    "core/linux-lts",
    "core/linux-lts-headers",
]

SWAY_PKGS = [
    "aur/brillo",
    "aur/flashfocus-git",
    "aur/ruby-fusuma",
    "aur/ruby-fusuma-plugin-keypress",
    "aur/ruby-fusuma-plugin-sendkey",
    "community/grim",
    "community/i3status-rust",
    "extra/libpipewire02",
    "extra/pipewire-docs",
    "extra/pipewire-pulse",
    "community/playerctl",
    "community/python-i3ipc",
    "community/sway",
    "community/swayidle",
    "aur/swaylock-effects-git",
    "community/slurp",
    "aur/swayr",
    "aur/wdisplays-git",
    # "aur/wev",
    "aur/wev-git",
    "community/wl-clipboard",
    "community/wmname",
    "aur/wob",
    "aur/wofi",
    "extra/xdg-desktop-portal",
    "community/xdg-desktop-portal-wlr",
    "extra/xfce4-notifyd",  # TODO: remove
    "aur/ydotool-git",
]

APPS_PKGS = [
    "aur/alacritty-ligatures",
    "aur/chromium-snapshot-bin",
    "aur/etcher-bin",
    "extra/firefox",
    "extra/gnome-font-viewer",
    "aur/google-chrome",
    "extra/gvim",
    # "community/kicad",
    # "community/kicad-library",
    # "aur/sparkfun-kicad-lib-git",
    "extra/nautilus",
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
    "community/webfs",
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
    "aur/glow-bin",  # CLI markdown renderer
    "aur/gotty-bin",  # share terminal as web app
    "community/inotify-tools",
    "community/jq",
    "extra/libqalculate",
    "extra/lsof",
    "community/moreutils",
    "extra/p7zip",
    "community/python-html2text",
    "community/ripgrep",
    "extra/screen",
    "aur/shellcheck-bin",
    "aur/slackcat",
    "community/shfmt",
    "community/sl",
    "community/tldr",
    "community/tmux",
    "extra/tree",
    "aur/ttyd",
    "aur/universal-ctags-git",
    "aur/up",
    "aur/zoxide-bin",
]

DEVELOPMENT_PKGS = [
    "aur/adr-tools",
    "aur/asdf-vm",
    # "community/aws-cli",
    # "aur/awslogs",
    # "community/ccache",
    "aur/ccls",
    "community/cloc",
    "community/docker",
    "community/docker-compose",
    "aur/git-delta",
    "aur/gitlab-glab-bin",
    "aur/google-cloud-sdk",
    "aur/gopls",  # Go language server
    "aur/hadolint-bin",  # Dockerfile linter
    "community/leiningen",
    "community/libmemcached",
    # "community/nim",
    "aur/postman6-bin",
    "extra/strace",
    "community/terraform",
    "aur/tflint-bin",
    "aur/vscode-html-languageserver-bin",
    # "community/zig",
]

PYTHON_PKGS = [
    "community/ipython",
    "community/mypy",
    "community/pylama",
    "community/pyenv",
    "community/python-black",
    "aur/python38",
    "extra/python-cffi",
    "aur/python-launcher",
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
    "community/audacity",
    "extra/gimp",
    "extra/graphicsmagick",
    "extra/graphviz",
    "aur/imgur.sh",
    "community/imv",
    "community/mediainfo",
    "community/mupdf",
    "aur/pandoc-bin",
    "aur/python-grip",
    "community/sox",
    "extra/vlc",
    "community/youtube-dl",
    "community/zathura",
    "community/zathura-pdf-mupdf",
]

ANDROID_PKGS = [
    "community/android-tools",
    "aur/scrcpy",
]

MISC_PKGS = [
    "extra/snappy",
    "extra/tk",
]

FONT_PKGS = [
    "community/otf-font-awesome",
    "community/ttf-font-awesome",
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

DATABASE_PKGS = [
    "community/dbeaver",
    # "aur/pgadmin4-last",
    "aur/pgcli",
    "extra/postgresql",
    "community/redis",
    "aur/sqlfluff",
]

MEDIA_PACKAGES = ""  # see: DOCUMENTS_AND_MEDIA_PKGS

JS_PACKAGES = [
    "community/deno",
    "aur/flow-bin",  # type checker for JS
    "aur/javascript-typescript-langserver",
    "community/npm",
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
    "database": DATABASE_PKGS,
    "js": JS_PACKAGES,
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
