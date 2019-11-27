import os


PACKAGES = [
    # Sway
    "community/sway",
    "aur/swaylock-effects-git",
    "community/rofi",

    # Fonts
    "community/otf-font-awesome",
    "aur/ttf-input",

    # Shell utils
    "community/fd",
    "community/fzf",
    "extra/tree",

    # Python
    "community/pyenv",
]


def install(packages):
    pkgs = " ".join(packages)
    os.system(f"yay -S --needed {pkgs}")


if __name__ == "__main__":
    install(PACKAGES)
