import platform

from config import DOTFILES_DIR, HOME_DIR
from lib import ask

OS = platform.system()

LINKS = {
    "bin": "Bin",
    "bash/bashrc": ".bashrc",
    "bash/bash_profile": ".bash_profile",
    "bash/inputrc": ".inputrc",
    "ctags/config.ctags": ".ctags.d/config.ctags",
    # "git/config": ".gitconfig",
    "git/ignore": ".gitignore",
    "ipython/ipython_config.py": ".ipython/profile_default/ipython_config.py",
    "ipython/startup/vim.py": ".ipython/profile_default/startup/vim.py",
    "neovim": ".config/nvim",
    "starship/starship.toml": ".config/starship.toml",
    "TabNine.toml": ".config/TabNine/TabNine.yml",
    "tmux/tmux.conf": ".tmux.conf",
    "wezterm": ".config/wezterm",
}

# TODO: add kitty terminal config
MACOS_LINKS = {
    "hammerspoon/init.lua": ".hammerspoon/init.lua",
    "yabai/yabairc": ".config/yabai/yabairc",
}


def create_links():
    if not ask("Create symlinks?"):
        return

    print("Creating symlinks")
    print("Dotfiles path:", DOTFILES_DIR)

    links = {
        **LINKS,
        **(MACOS_LINKS if OS == "Darwin" else {}),
    }

    for src, dest in links.items():
        src_path = DOTFILES_DIR / src
        dest_path = HOME_DIR / dest

        dest_dir = dest_path.parent
        if not dest_dir.exists():
            print(f"Creating {dest_dir}")
            dest_dir.mkdir(parents=True)

        print(f"Linking {dest_path} -> {src_path}")
        if dest_path.is_symlink():
            dest_links_to = dest_path.resolve()
            if dest_links_to != src_path and ask(
                f"\t{dest_path} is a symlink to {dest_links_to}, overwrite?"
            ):
                link(src_path, dest_path, unlink=True)
        elif dest_path.is_file():
            if ask(f"\t{dest_path} is a regular file, overwrite?"):
                link(src_path, dest_path, unlink=True)
        else:
            link(src_path, dest_path)


def link(src_path, dest_path, *, unlink=False):
    try:
        if unlink:
            print(f"\tremoving {dest_path}")
            dest_path.unlink()
        print(f"\tlinking {dest_path} -> {src_path}")
        dest_path.symlink_to(src_path)
    except Exception as e:
        print("\t", e)


if __name__ == "__main__":
    create_links()
